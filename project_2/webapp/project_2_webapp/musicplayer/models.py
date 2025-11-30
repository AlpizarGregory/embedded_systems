from django.db import models

# Create your models here.
class Song(models.Model):
    title = models.CharField(max_length=150)
    artist = models.CharField(max_length=150)
    album = models.CharField(max_length=150)
    playback_time = models.CharField(max_length=20)
    full_time = models.CharField(max_length=20)
    progress = models.CharField(max_length=3)
    status = models.CharField(max_length=150)
