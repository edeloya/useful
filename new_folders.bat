@ECHO OFF
FOR %%A IN (*.mkv,*.mp4) do (IF NOT EXIST "%%~dpA%%~nA" (mkdir "%%~nA" && move "%%A" "%%~nA") ELSE move "%%A" "%%~nA")
::del %0