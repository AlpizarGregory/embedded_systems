from .models import Song


def read_song_info():
    try:
        with open("../output.txt", "r") as file:
            content = file.read()

        return content
    except Exception:
        return None


def set_progress_bar(playback_time, full_time):
    playback_time = playback_time.split(":")
    full_time = full_time.split(":")

    playback_time_seconds = ( int(playback_time[0]) * 60 ) + (int(playback_time[1]))
    full_time_seconds = ( int(full_time[0]) * 60 ) + (int(full_time[1]))
    progress = int((playback_time_seconds * 100) / full_time_seconds)

    return progress


def create_song_instance(raw_data):
    song_data = raw_data.split(",")
    progress = set_progress_bar(song_data[3], song_data[4])
    song_instance = {
        "title": song_data[0],
        "artist": song_data[1],
        "album": song_data[2],
        "playback_time": song_data[3],
        "full_time": song_data[4],
        "status": song_data[5],
        "progress": progress
    }

    return song_instance
