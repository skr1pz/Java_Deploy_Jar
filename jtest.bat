@echo off

java -version 2>.\jtext.txt
for /f "tokens=2 delims=_" %%A IN (jtext.txt) do echo %%A
pause
