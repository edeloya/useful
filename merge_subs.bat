for %%A IN (*.mkv) do (mkvmerge "%%A" "%%~nA.srt" -o "~%%A") && recycle /f  "%%~nA.srt" && recycle /f  "%%A" && ren "~%%A" "%%A"
pause
