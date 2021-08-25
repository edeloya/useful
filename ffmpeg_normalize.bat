for %%A in (*.mkv) do (ffmpeg-normalize "%%A" -c:v copy -c:a aac -f -v -nt peak -t 0 && recycle /f "%%A" && move "normalized\%%A" .)
rmdir normalized
pause