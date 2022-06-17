for %%A in (*.mkv) do (mkvmerge -o "~%%A" --no-chapters "%%A" --chapters "%%~nA_chapters.xml") && recycle /f "%%A" && recycle /f "%%~nA_chapters.xml" && ren "~%%A" "%%A"
pause