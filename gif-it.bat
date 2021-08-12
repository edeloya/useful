@ECHO off
cd %~dp0
SET res=%2
SET start=%3
SET end=%4

color a
chcp 65001
cls

IF [%1] NEQ [] (
    SET file=%1
    GOTO :CLI
    ) ELSE (
    GOTO :EXEC
)

:EXEC
SET /p file="File w/ extension pls: "
SET /p res="Resolution (# only): "
SET /p start="Start time (Default: 0): "
SET /p end="End time (Default: Full file duration): "
IF [%start%] EQU [] (
    SET start=0
    )
IF [%end%] EQU [] (
    FOR /F "tokens=* USEBACKQ" %%A IN (`ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 "%file%"`) DO (SET dur=%%A)
    ) ELSE (SET dur=%end%)

ffmpeg -ss %start% -to %dur% -i "%file%" -an -vf "fps=15,scale=-2:%res%:flags=lanczos,split[s0][s1];[s0]palettegen=stats_mode=single[p];[s1][p]paletteuse" -loop 0 "%file:~0,-4%.gif" -y
PAUSE
GOTO :EOF

:CLI
FOR /F "tokens=* USEBACKQ" %%A IN (`ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 "%1"`) DO (SET dur=%%A)
IF [%start%] EQU [] SET start=0

CALL SET time=-ss %start% -to %dur%
ffmpeg %time% -i "%file%" -an -vf "fps=15,scale=-2:%res%:flags=lanczos,split[s0][s1];[s0]palettegen=stats_mode=single[p];[s1][p]paletteuse" -loop 0 "%~n1.gif" -y
GOTO :EOF