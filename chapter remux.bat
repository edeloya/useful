@echo off
:run
SET /P num="What ep? "&& echo[
SET /P chapter="What chapter XML(long or reg): " && echo[

mkvmerge -o "~ep%num%.mkv" --no-chapters "ep%num%.mkv" --chapters "%chapter%.xml" && recycle /f "ep%num%.mkv" && ren "~ep%num%.mkv" "ep%num%.mkv" && echo[

SET /P flag="Repeat? (y|n) " && echo[
IF NOT %flag%==y GOTO end ELSE GOTO run
:end