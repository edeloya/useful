for %%A IN (*.mkv) do (ffmpeg -i "%%A" -c:a aac -ac 6 "%%~nA".aac) ^
&& ("mkvmerge" --output "~%%A" "%%A" --track-name 0:5.1 "%%~nA.aac" --title "%%~nA" --track-order 0:0,0:1,1:0) ^
&& del "%%~nA.aac" && del "%%A" && ren "~%%~nxA" "%%~nxA"
pause