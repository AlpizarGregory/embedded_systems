from django.urls import path

from . import views

urlpatterns = [
    path("", views.player_view, name="player_view"),
    path("retrieve_song_info", views.retrieve_song_info, name="retrieve_song_info"),
]
