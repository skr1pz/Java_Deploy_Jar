@ECHO off
:JCheck
SET KIT=JavaSoft\Java Runtime Environment
call:ReadRegValue VER "HKLM\Software\%KIT%" "CurrentVersion"
IF "%VER%" NEQ "" GOTO FoundJRE

SET KIT=Wow6432Node\JavaSoft\Java Runtime Environment
call:ReadRegValue VER "HKLM\Software\%KIT%" "CurrentVersion"
IF "%VER%" NEQ "" GOTO FoundJRE

SET KIT=JavaSoft\Java Development Kit
call:ReadRegValue VER "HKLM\Software\%KIT%" "CurrentVersion"
IF "%VER%" NEQ "" GOTO FoundJRE

SET KIT=Wow6432Node\JavaSoft\Java Development Kit
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

:Install
taskkill /f /im iexplore.exe
taskkill /f /im firefox.exe
taskkill /f /im chrome.exe
taskkill /f /im safari.exe
::\\uhs61927\jdk\jre-7u51-windows-i586.exe /s AgreeToLicense=YES IEXPLORER=1 MOZILLA=1 REBOOT=Suppress JAVAUPDATE=0
\\uhs61927\jdk\jre-7u51-windows-i586.exe /s /v "AgreeToLicense=YES IEXPLORER=1 MOZILLA=1 REBOOT=Suppress JAVAUPDATE=0" /qn
GOTO JCheck

:Commands
taskkill /f /im java.exe
\\uhs61927\jdk\keytool -importcert -trustcacerts -keystore "%JAVAPATH%\lib\security\cacerts" -storepass "changeit" -file "\\uhs61927\jdk\caroot.cer" -noprompt
if not exist "%windir%\Sun\Java\Deployment\" md "%windir%\Sun\Java\Deployment\"
copy "\\uhs61927\jdk\DeploymentRuleSet.jar" %windir%\Sun\Java\Deployment\

pause

exit