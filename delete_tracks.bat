FOR %%A IN (*.mkv) DO (mkvmerge -o "~%%A" -S "%%A") && recycle /f  "%%A" && ren "~%%A" "%%A"
:: -a & -s preserve tracks. mkvmerge -i <filename> for track info
PAUSE