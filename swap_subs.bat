FOR %%A IN (*.mkv) DO (mkvmerge -S "%%A" "%%~nA.ass" -o "~%%A" && recycle /f  "%%~nA.ass" && recycle /f  "%%A" && ren "~%%A" "%%A")
PAUSE
