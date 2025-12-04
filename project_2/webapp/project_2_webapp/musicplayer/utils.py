import socket

from .models import Song

SERVER_IP = '172.18.178.243'   # FPGA's IP
SERVER_PORT = 5000


def read_song_info():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    s.connect((SERVER_IP, SERVER_PORT))

    message = "get_data"

    # Send message to server
    s.sendall(message.encode())

    # Receive response
    data = s.recv(1024)
    text = data.decode("utf-8") + ",END"

    s.close()

    return text


def set_progress_bar(playback_time, full_time):
    playback_time = playback_time.split(":")
    full_time = full_time.split(":")

    playback_time_seconds = ( int(playback_time[0]) * 60 ) + (int(playback_time[1]))
    full_time_seconds = ( int(full_time[0]) * 60 ) + (int(full_time[1]))
    progress = int((playback_time_seconds * 100) / full_time_seconds)

    return progress


def create_song_instance(raw_data):
    song_data = raw_data.split(",")
    playback_time = song_data[3]
    playback_time_str = "{}:{}".format(str(int(int(playback_time) / 60)).zfill(2), str(int(int(playback_time) % 60)).zfill(2))
    full_time = song_data[4]
    full_time_str = "{}:{}".format(str(int(int(full_time) / 60)).zfill(2), str(int(int(full_time) % 60)).zfill(2))
    progress = set_progress_bar(playback_time_str, full_time_str)
    song_instance = {
        "title": song_data[0],
        "artist": song_data[1],
        "album": song_data[2],
        "playback_time": playback_time_str,
        "full_time": full_time_str,
        "status": song_data[5] == "1",
        "progress": progress
    }

    print(song_data)

    return song_instance
