::@ECHO OFF
SET /p url="Paste YouTube URL: "
SET /p ss="Start (seconds or timecode): "
SET /p t="End (seconds or timecode): "
SET /p res="Resolution (# only, -1 for default): "

:: Get filename from yt-dlp
FOR /F "tokens=*" %%a IN ('yt-dlp --restrict-filenames --get-filename "%url%"') DO SET vartmp=%%a

:: Extract full filename (robust way)
FOR %%f IN ("%vartmp%") DO SET coolvid=%%~nf.mkv

:: Download file
yt-dlp --restrict-filenames -t mkv "%url%"

:: Check if file exists
IF NOT EXIST "%coolvid%" (
    ECHO Error: File %coolvid% not found.
    PAUSE
    EXIT /B 1
)

:: Run ffmpeg
ffmpeg -ss %ss% -to %t% -i "%coolvid%" -vf "fps=15,scale=-2:%res%:flags=lanczos,split[s0][s1];[s0]palettegen=stats_mode=single[p];[s1][p]paletteuse" output.gif -y

:: Delete original file
del "%coolvid%" /f /q

PAUSE


::more info at:
::https://ss64.com/nt/for_f.html
::https://ss64.com/nt/set.html
::https://ss64.com/nt/syntax-substring.html

::useful ffmpeg filters
::https://ffmpeg.org/ffmpeg-filters.html#Examples-142
::https://ffmpeg.org/ffmpeg-filters.html#scale-1

::-vf "scale=-2:360,setpts=0.5*PTS" -> -vf uses filters/params in QUOTES, delimited by COMMA
::scale=h:w, -n to make sure its a multiple of n (-2 tells it to autoscale to an even h at approx natural aspect ratio to 360)
::setpts=0.5*PTS, change presentation timestamp by multiple. .5*PTS speeds up video by 
