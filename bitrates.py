import os, re, collections, pprint
from pymediainfo import MediaInfo
from pymkv import MKVFile

os.chdir('D:\\lol\\x265')
videos = EPS = []

if os.path.isdir('tmp') == False:
    os.mkdir('tmp')

for filename in os.listdir():                                                       #Search current dir for *.mkv's
    if filename.endswith('.mkv'):
        videos.append(filename)

for every in videos:
    mkv = MKVFile(every)
    mkv.split_duration(60)
    mkv.mux('tmp\\'+mkv.tracks[0].file_path)

videos.clear()
for filename in os.listdir('tmp'):
    videos.append(filename)

regX = [re.findall(r'(S\d{2}E\d{2}|\-\d{2,})', filename) for filename in videos]    #RegEx outSXXEXX' and slice #

vidz = [[X,                                                                         #<filename>
        (regX[videos.index(X)][0],regX[videos.index(X)][1]),                        #('S02E01', '-003')
        MediaInfo.parse('tmp\\'+X).tracks[1].bit_rate//1000]                        #Bitrate
        for X in videos
        ]

for X in vidz:
    EPS.append(X[1][0])

unique_ep_dict = dict.fromkeys(X[1][0] for X in vidz)

for ep in unique_ep_dict:
    for slice in vidz:
        
    

os.system('pause')