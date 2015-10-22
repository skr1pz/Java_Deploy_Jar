@echo off
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment" /v CurrentVersion> jversion.txt
FOR /F "usebackq skip=2 tokens=3" %%A IN (jversion.txt) do reg query "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment\%%A" /v JavaHome > jhome.txt
FOR /F "usebackq skip=2 tokens=3,4" %%B IN (jhome.txt) do @echo %%B %%C 

pause
