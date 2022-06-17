import sys, os, ffmpeg, unsilence
from pymediainfo import MediaInfo

for X in os.listdir():
    if X.endswith('.mp4'):
        media_info = MediaInfo.parse(X)
        for track in media_info.tracks:
            if track.track_type == "Video":
                print(track.bit_rate//1000)
print()
os.system("Pause")
