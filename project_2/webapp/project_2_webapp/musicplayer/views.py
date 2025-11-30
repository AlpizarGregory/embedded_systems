from django.http import HttpResponse, JsonResponse
from django.shortcuts import render
from django.template import loader

from .utils import read_song_info, create_song_instance

# Create your views here.
def player_view(request):
    template = loader.get_template("musicplayer/player_view.html")

    return HttpResponse(template.render({}, request))


def retrieve_song_info(request):
    info = read_song_info()
    context = {}
    if info:
        song = create_song_instance(info)
        context["song"] = song

    return render(request, "musicplayer/retrieve_song_info.html", context)
