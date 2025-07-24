@ECHO OFF
cd %~dp0

::###########  Unsilence  #############
::#########      Defaults    ##########

::  Speed when sounds are detected
SET as=1.18

::  Speed when "silence" is detected
SET ss=12

::  Volume when sounds
SET av=1

::  Volume when "silence"
SET sv=0.3

::#####################################
::#####################################

SET /p url="Paste YouTube URL: "

color a
chcp 65001
cls

ECHO.&&ECHO.
ECHO     🎷🐛
ECHO    $$$$$\                               $$\      $$\
ECHO    \__$$ ^|                              $$ ^| $\  $$ ^|                           🎷🐛
ECHO       $$ ^| $$$$$$\  $$$$$$$$\ $$$$$$$$\ $$ ^|$$$\ $$ ^| $$$$$$\   $$$$$$\  $$$$$$\$$$$\
ECHO       $$ ^| \____$$\ \____$$  ^|\____$$  ^|$$ $$ $$\$$ ^|$$  __$$\ $$  __$$\ $$  _$$  _$$\
ECHO $$\   $$ ^| $$$$$$$ ^|  $$$$ _/   $$$$ _/ $$$$  _$$$$ ^|$$ /  $$ ^|$$ ^|  \__^|$$ / $$ / $$ ^|
ECHO $$ ^|  $$ ^|$$  __$$ ^| $$  _/    $$  _/   $$$  / \$$$ ^|$$ ^|  $$ ^|$$ ^|      $$ ^| $$ ^| $$ ^|
ECHO \$$$$$$  ^|\$$$$$$$ ^|$$$$$$$$\ $$$$$$$$\ $$  /   \$$ ^|\$$$$$$  ^|$$ ^|      $$ ^| $$ ^| $$ ^|
ECHO  \______/  \_______^|\________^|\________^|\__/ 🎷🐛\__^| \______/ \__^|      \__^| \__^| \__^|


yt-dlp "%url%" -o "tmp\%%(playlist_index)s-%%(title)s.%%(ext)s" --restrict-filename

cd tmp
FOR %%A IN (*.*) DO (unsilence "%%A" "..\%%~nA.mkv" -as %as% -ss %ss% -av %av% -sv %sv% -t %NUMBER_OF_PROCESSORS% -y)
cd ..\
rmdir /s /q tmp
