FOR %%A in (*.mkv) DO (mkvmerge --ui-language en -o "a\%%~nA.mkv" --language 1:Eng "%%A" --split duration:60s --track-order 0:0,0:1)
exit /b