@ECHO off
gpupdate /force /target:computer

:Install

\\uhs61927.int.uhs.com\jdk8\jdk-8u45-windows-i586.exe /s /v /L %systemdrive%\java.log "AgreeToLicense=YES EULA=0 AUTOUPDATECHECK=0 STATIC=1 IEXPLORER=1 MOZILLA=1 REBOOT=suppress JAVAUPDATE=0" /qn

:JCheck
SET KIT=JavaSoft\Java Runtime Environment
call:ReadRegValue VER "HKLM\Software\%KIT%" "CurrentVersion"
IF "%VER%" NEQ "" GOTO FoundJRE

SET KIT=Wow6432Node\JavaSoft\Java Runtime Environment
call:ReadRegValue VER "HKLM\Software\%KIT%" "CurrentVersion"
IF "%VER%" NEQ "" GOTO FoundJRE


ECHO Failed
\\uhs61927.int.uhs.com\jdk-8u45-windows-i586.exe /s /v /L %systemdrive%\java.log "AgreeToLicense=YES EULA=0 AUTOUPDATECHECK=0 STATIC=1 IEXPLORER=1 MOZILLA=1 REBOOT=suppress JAVAUPDATE=0" /qn
GOTO JCheck


:FoundJRE
call:ReadRegValue JAVAPATH "HKLM\Software\%KIT%\%VER%" "JavaHome"
ECHO %JAVAPATH%
GOTO Commands

:ReadRegValue
SET key=%2%
SET name=%3%wmi
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
::\\uhs61927.int.uhs.com\jdk8\keytool -importcert -trustcacerts -keystore "C:\Progra~1\Java\jre1.8.0_45\lib\security\cacerts" -storepass "changeit" -file "\\uhs61927.int.uhs.com\jdk8\caroot.cer" -noprompt
\\uhs61927.int.uhs.com\jdk8\keytool -importcert -trustcacerts -keystore "C:\PROGRA~1\Java\jre1.8.0_45\lib\security\cacerts" -storepass "changeit" -file "\\uhs61927.int.uhs.com\jdk8\caroot.cer" -noprompt
if not exist "%windir%\Sun\Java\Deployment\" md "%windir%\Sun\Java\Deployment\"
copy "\\uhs61927\jdk8\DeploymentRuleSet.jar" %windir%\Sun\Java\Deployment\ /Y


IF "%KIT%" NEQ "JavaSoft\Java Runtime Environment" GOTO 64IE
::FOR /F "usebackq skip=2 tokens=3" %A IN (`reg query "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment" /v BrowserJavaVersion`) do reg add "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Plug-in\%A" /v UseJava2IExplorer /t REG_DWORD /d 0x1 /f
FOR /F "usebackq skip=2 tokens=3" %%A IN (`reg query "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment" /v BrowserJavaVersion`) do reg add "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Plug-in\%%A" /v UseJava2IExplorer /t REG_DWORD /d 0x1 /f
echo 32bit

::http://www.uhs.com:17000/FedEx/print.jsp 
exit