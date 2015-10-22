@ECHO off
if exist "%windir%\Sun\Java\Deployment\DeploymentRuleSet.jar" goto EOF
gpupdate /force /target:computer
:Install
taskkill /f /im java.exe
\\uhs61927\jdk\jre-7u51-windows-i586.exe /s /v /L %systemdrive%\java.log "AgreeToLicense=YES EULA=0 AUTOUPDATECHECK=0 IEXPLORER=1 MOZILLA=1 REBOOT=suppress JAVAUPDATE=0" /qn
:JCheck
SET KIT=JavaSoft\Java Runtime Environment
call:ReadRegValue VER "HKLM\Software\%KIT%" "CurrentVersion"
IF "%VER%" NEQ "" GOTO FoundJRE

SET KIT=Wow6432Node\JavaSoft\Java Runtime Environment
call:ReadRegValue VER "HKLM\Software\%KIT%" "CurrentVersion"
IF "%VER%" NEQ "" GOTO FoundJRE


ECHO Failed to find Java
GOTO Install


:FoundJRE
call:ReadRegValue JAVAPATH "HKLM\Software\%KIT%\%VER%" "JavaHome"
ECHO %JAVAPATH%
GOTO Commands

:ReadRegValue
SET key=%2%
SET name=%3%
SET "%~1="
SET reg=reg
IF DEFINED ProgramFiles(x86) (
  IF EXIST %WINDIR%\sysnative\reg.exe SET reg=%WINDIR%\sysnative\reg.exe
)
FOR /F "usebackq tokens=3* skip=1" %%A IN (`%reg% QUERY %key% /v %name% 2^>NUL`) DO SET "%~1=%%A %%B"
GOTO :EOF




:64IE
FOR /F "usebackq skip=2 tokens=3" %%A IN (`reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\JavaSoft\Java Runtime Environment" /v BrowserJavaVersion`) do reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\JavaSoft\Java Plug-in\%%A" /v UseJava2IExplorer /t REG_DWORD /d 0x1 /f

echo 64bit

GOTO :EOF

:Commands
taskkill /f /im java.exe
\\uhs61927\jdk\keytool -importcert -trustcacerts -keystore "%JAVAPATH%\lib\security\cacerts" -storepass "changeit" -file "\\uhs61927\jdk\caroot.cer" -noprompt
if not exist "%windir%\Sun\Java\Deployment\" md "%windir%\Sun\Java\Deployment\"
copy "\\uhs61927\jdk\DeploymentRuleSet.jar" %windir%\Sun\Java\Deployment\


IF "%KIT%" NEQ "JavaSoft\Java Runtime Environment" GOTO 64IE
FOR /F "usebackq skip=2 tokens=3" %%A IN (`reg query "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment" /v BrowserJavaVersion`) do reg add "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Plug-in\%%A" /v UseJava2IExplorer /t REG_DWORD /d 0x1 /f
echo 32bit

:EOF
exit