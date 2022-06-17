@ECHO OFF
SET /p file="Input filename (with extension): "

::FOR loops through "tokens" in the file output, storing them for use with SET
::you can specify "tokens=3" to ONLY set vartmp to the 3rd "word" from the findstr output

ffmpeg -i "%file%" -t 10 -vf cropdetect -f null - 2> crop.tmp
FOR /F "useback tokens=14 delims= " %%A IN ("crop.tmp") DO (SET "lastline=%%A")
ffmpeg -i "%file%" -vf "%lastline%" "%file:~0,-4%_cropped.mkv"
del crop.tmp
PAUSE

::more info at:
::https://ss64.com/nt/for_f.html
::https://ss64.com/nt/set.html
::https://ss64.com/nt/syntax-substring.html
