mkdir output
FOR %%X IN (*.mkv) DO (FOR %%Y IN (*.yaml) DO (video2x -b -m cudnn -c "%%Y" -r 2 -i "%%X" -o "output\%%~nX_%%~nY.mkv" > "output\%%~nX_%%~nY.txt"))
findstr /c:"Program completed" *.txt
pause