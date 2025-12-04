#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <dirent.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <pthread.h> // Necesario para ejecutar tareas en paralelo

// -----------------------------------------------------------
//  CONFIGURACIÓN HARDWARE
// -----------------------------------------------------------
#define HW_REGS_BASE       0xFF200000
#define HW_REGS_SPAN       0x00200000
#define FIFO_IN_OFFSET      0x00000020
#define FIFO_IN_CSR_OFFSET  0x00000000
#define AUDIO_CHUNK 4096  // Aumentado un poco para eficiencia

// -----------------------------------------------------------
//  ESTRUCTURA DE DATOS COMPARTIDA (METADATA)
// -----------------------------------------------------------
struct PlayerState {
    char title[128];
    char artist[128];
    char album[128];
    int current_time;
    int total_duration;
    int now_playing; // 1 = Reproduciendo, 0 = Detenido
    pthread_mutex_t lock; // Candado para evitar conflictos de lectura/escritura
};

// Variable global compartida
struct PlayerState player_state;

// -----------------------------------------------------------
//  HILO SECUNDARIO: Actualiza meta.txt cada segundo
// -----------------------------------------------------------
void *meta_updater_thread(void *arg) {
    while (1) {
        // 1. Bloquear acceso a la estructura para leer datos seguros
        pthread_mutex_lock(&player_state.lock);
        
        char t_title[128], t_artist[128], t_album[128];
        int t_curr, t_dur, t_play;

        // Copiar datos a variables locales
        strcpy(t_title, player_state.title);
        strcpy(t_artist, player_state.artist);
        strcpy(t_album, player_state.album);
        t_curr = player_state.current_time;
        t_dur = player_state.total_duration;
        t_play = player_state.now_playing;
        
        pthread_mutex_unlock(&player_state.lock);

        // 2. Escribir al archivo (Sobrescribir)
        FILE *f = fopen("meta.txt", "w");
        if (f) {
            // Formato: title,artist,album,CurrentTime,TotalDuration,NowPlaying
            fprintf(f, "%s,%s,%s,%d,%d,%d\n", 
                    t_title, t_artist, t_album, t_curr, t_dur, t_play);
            fflush(f); // Forzar escritura al disco
            fclose(f);
        }

        // 3. Dormir 1 segundo
        sleep(1);
    }
    return NULL;
}

// -----------------------------------------------------------
//  FUNCIONES DE HARDWARE
// -----------------------------------------------------------
int wait_fifo_space(volatile uint32_t *fifo_csr) {
    int timeout = 2000000;
    while ((*fifo_csr) & 0x01) { // Bit 0 = FULL
        if (--timeout == 0) return 0;
        usleep(1);
    }
    return 1;
}

// -----------------------------------------------------------
//  AYUDA: Extraer Metadata básica del WAV (RIFF INFO)
// -----------------------------------------------------------
// Nota: Parsear RIFF completo en C puro es complejo. 
// Esta función busca cadenas simples o usa valores por defecto.
void extract_metadata(const char *filename, FILE *fp) {
    pthread_mutex_lock(&player_state.lock);
    
    // Por defecto: Usar nombre de archivo como título, y Unknown en el resto
    strncpy(player_state.title, filename, 127);
    strcpy(player_state.artist, "Unknown Artist");
    strcpy(player_state.album, "Unknown Album");
    
    // Aquí se podría implementar un parser de RIFF INFO chunks 
    // buscando "INAM" (Title) o "IART" (Artist) dentro del archivo.
    // Para mantener el código estable y rápido, usamos el filename por ahora.
    
    pthread_mutex_unlock(&player_state.lock);
}

// -----------------------------------------------------------
//  REPRODUCCIÓN
// -----------------------------------------------------------
void play_wav(const char *filename, volatile uint32_t *fifo_in, volatile uint32_t *fifo_csr) {
    printf("[INFO] Cargando: %s\n", filename);

    FILE *fp = fopen(filename, "rb");
    if (!fp) {
        printf("[ERROR] No se pudo abrir %s\n", filename);
        return;
    }

    // --- LEER CABECERA WAV PARA CALCULAR TIEMPO ---
    uint8_t header[44];
    fread(header, 1, 44, fp);

    // ByteRate está en el offset 28 (4 bytes)
    uint32_t byte_rate = header[28] | (header[29] << 8) | (header[30] << 16) | (header[31] << 24);
    
    // File Size está en el offset 4 (4 bytes), restamos cabecera para datos de audio
    fseek(fp, 0, SEEK_END);
    long file_size = ftell(fp);
    long audio_data_size = file_size - 44;
    fseek(fp, 44, SEEK_SET); // Volver al inicio del audio

    // Calcular duración total en segundos
    int duration_sec = 0;
    if (byte_rate > 0) {
        duration_sec = audio_data_size / byte_rate;
    }

    // --- ACTUALIZAR METADATA INICIAL ---
    extract_metadata(filename, fp);
    
    pthread_mutex_lock(&player_state.lock);
    player_state.total_duration = duration_sec;
    player_state.current_time = 0;
    player_state.now_playing = 1;
    pthread_mutex_unlock(&player_state.lock);

    // --- BUCLE DE REPRODUCCIÓN ---
    uint8_t buffer[AUDIO_CHUNK];
    long total_bytes_read = 0;

    while (1) {
        size_t n = fread(buffer, 1, AUDIO_CHUNK, fp);
        if (n == 0) break;

        // Actualizar tiempo actual (basado en bytes leídos)
        total_bytes_read += n;
        if (byte_rate > 0) {
            int current_sec = total_bytes_read / byte_rate;
            
            // Solo actualizamos el estado si cambió el segundo (optimización)
            if (current_sec != player_state.current_time) {
                pthread_mutex_lock(&player_state.lock);
                player_state.current_time = current_sec;
                pthread_mutex_unlock(&player_state.lock);
            }
        }

        // Enviar al FIFO
        size_t i = 0;
        while (i < n) {
            if (!wait_fifo_space(fifo_csr)) {
                printf("[ERROR] FIFO colgado.\n");
                fclose(fp);
                return;
            }
            uint32_t word = 0;
            for (int b = 0; b < 4 && i < n; b++, i++) {
                word |= buffer[i] << (8 * b);
            }
            *fifo_in = word;
        }
    }

    fclose(fp);
}

// -----------------------------------------------------------
//  CARGA DE ARCHIVOS
// -----------------------------------------------------------
int load_playlist(const char *folder, char songs[][128], int max_songs) {
    DIR *d = opendir(folder);
    if (!d) return 0;
    int count = 0;
    struct dirent *entry;
    while ((entry = readdir(d)) != NULL) {
        if (strstr(entry->d_name, ".wav")) {
            snprintf(songs[count], 128, "%s", entry->d_name); // Guardamos solo nombre, no ruta completa
            count++;
            if (count >= max_songs) break;
        }
    }
    closedir(d);
    return count;
}

// -----------------------------------------------------------
//  MAIN
// -----------------------------------------------------------
int main() {
    setbuf(stdout, NULL);
    printf("[INFO] Iniciando Player con Metadata Service...\n");

    // 1. Inicializar mutex
    if (pthread_mutex_init(&player_state.lock, NULL) != 0) {
        printf("[ERROR] Falló init mutex\n");
        return 1;
    }

    // 2. Iniciar hilo de actualización de meta.txt
    pthread_t thread_id;
    if (pthread_create(&thread_id, NULL, meta_updater_thread, NULL) != 0) {
        printf("[ERROR] Falló al crear hilo.\n");
        return 1;
    }

    // 3. Mapeo de Hardware
    int fd = open("/dev/mem", O_RDWR | O_SYNC);
    if (fd < 0) return 1;
    void *lw = mmap(NULL, HW_REGS_SPAN, PROT_READ | PROT_WRITE, MAP_SHARED, fd, HW_REGS_BASE);
    if (lw == MAP_FAILED) return 1;

    volatile uint32_t *fifo_in = (uint32_t*)((uint8_t*)lw + FIFO_IN_OFFSET);
    volatile uint32_t *fifo_csr = (uint32_t*)((uint8_t*)lw + FIFO_IN_CSR_OFFSET);

    // 4. Cargar Playlist
    char playlist[32][128];
    int n = load_playlist(".", playlist, 32);

    if (n == 0) {
        printf("[ERROR] No hay canciones.\n");
        // Escribir estado vacío en meta.txt antes de salir
        pthread_mutex_lock(&player_state.lock);
        strcpy(player_state.title, "No Songs");
        player_state.now_playing = 0;
        pthread_mutex_unlock(&player_state.lock);
        return 1;
    }

    // 5. Reproducir Secuencialmente
    for (int i = 0; i < n; i++) {
        play_wav(playlist[i], fifo_in, fifo_csr);
    }

    // 6. Finalizar
    printf("[INFO] Playlist terminada.\n");
    
    pthread_mutex_lock(&player_state.lock);
    player_state.now_playing = 0;
    strcpy(player_state.title, "Stopped");
    player_state.current_time = 0;
    pthread_mutex_unlock(&player_state.lock);
    
    // Esperar un segundo para que el hilo escriba el estado final
    sleep(1); 

    munmap(lw, HW_REGS_SPAN);
    close(fd);
    pthread_mutex_destroy(&player_state.lock);
    
    return 0;
}
