import os
from pymediainfo import MediaInfo

for X in os.listdir():
        if X.endswith(".mp4"):
            print("{} Kbps".format((MediaInfo.parse(X).tracks[1].bit_rate)//1000))
print("\n")
os.system("Pause")
