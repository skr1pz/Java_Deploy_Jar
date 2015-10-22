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
\\uhs61927\jdk\jre-7u51-windows-i586.exe /s /v /L %systemdrive%\java.log "AgreeToLicense=YES EULA=0 AUTOUPDATECHECK=0 IEXPLORER=1 MOZILLA=1 REBOOT=Suppress JAVAUPDATE=0" /qn
GOTO JCheck


:64IE
FOR /F "usebackq skip=2 tokens=3" %%A IN (`reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\JavaSoft\Java Runtime Environment" /v BrowserJavaVersion`) do reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\JavaSoft\Java Plug-in\%%A" /v UseJava2IExplorer /t REG_DWORD /d 0x1 /f

echo 64bit
pause
GOTO :EOF

:Commands
taskkill /f /im java.exe
\\uhs61927\jdk\keytool -importcert -trustcacerts -keystore "%JAVAPATH%\lib\security\cacerts" -storepass "changeit" -file "\\uhs61927\jdk\caroot.cer" -noprompt
if not exist "%windir%\Sun\Java\Deployment\" md "%windir%\Sun\Java\Deployment\"
copy "\\uhs61927\jdk\DeploymentRuleSet.jar" %windir%\Sun\Java\Deployment\
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Approved Extensions" /v {761497BB-D6F0-462C-B6EB-D4DAF1D92D43} /t REG_BINARY /d 51667A6C4C1D3B1BAB8E0467CF844308A9FD9287F29F6F5B /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Approved Extensions" /v {DBC80044-A445-435B-BC74-9C25C1C588A9} /t REG_BINARY /d 51667A6C4C1D3B1B5419D8CA7AF6340DA362DA78C283CAB1 /f

::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{CAFEEFAC-DEC7-0000-0001-ABCDEFFEDCBA}" /ve /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{CAFEEFAC-DEC7-0000-0001-ABCDEFFEDCBA}\iexplore" /v Blocked /t REG_DWORD /d 0x2 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{CAFEEFAC-DEC7-0000-0001-ABCDEFFEDCBA}\iexplore" /v Flags /t REG_DWORD /d 0x4 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{CAFEEFAC-DEC7-0000-0001-ABCDEFFEDCBA}\iexplore" /v Count /t REG_DWORD /d 0x6 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{CAFEEFAC-DEC7-0000-0001-ABCDEFFEDCBA}\iexplore" /v Time /t REG_BINARY /d DF0704000500180013002F001E006C03 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{CAFEEFAC-DEC7-0000-0001-ABCDEFFEDCBA}\iexplore" /v Type /t REG_DWORD /d 0x1 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{CAFEEFAC-DEC7-0000-0001-ABCDEFFEDCBA}\iexplore\AllowedDomains" /ve /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{CAFEEFAC-DEC7-0000-0001-ABCDEFFEDCBA}\iexplore\AllowedDomains\uhs.com" /ve /f

::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{08B0E5C0-4FCB-11CF-AAA5-00401C608501}" /ve /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{08B0E5C0-4FCB-11CF-AAA5-00401C608501}\iexplore" /v Type /t REG_DWORD /d 0x1 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{08B0E5C0-4FCB-11CF-AAA5-00401C608501}\iexplore" /v Flags /t REG_DWORD /d 0x0 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{08B0E5C0-4FCB-11CF-AAA5-00401C608501}\iexplore" /v Count /t REG_DWORD /d 0x2 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{08B0E5C0-4FCB-11CF-AAA5-00401C608501}\iexplore" /v Time /t REG_BINARY /d DF0704000500180013002F001E008B03 /f

::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{25A3A431-30BB-47C8-AD6A-E1063801134F}\iexplore" /v Count /t REG_DWORD /d 0x5 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{25A3A431-30BB-47C8-AD6A-E1063801134F}\iexplore" /v Time /t REG_BINARY /d DF070400050018001600220022002F02 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{25A3A431-30BB-47C8-AD6A-E1063801134F}\iexplore" /v Blocked /t REG_DWORD /d 0x5 /f

::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{47833539-D0C5-4125-9FA8-0819E2EAAC93}\iexplore" /v Count /t REG_DWORD /d 0x5 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{47833539-D0C5-4125-9FA8-0819E2EAAC93}\iexplore" /v Time /t REG_BINARY /d DF070400050018001600220022002F02 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{47833539-D0C5-4125-9FA8-0819E2EAAC93}\iexplore" /v Blocked /t REG_DWORD /d 0x5 /f

::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{18DF081C-E8AD-4283-A596-FA578C2EBDC3}\iexplore" /v Count /t REG_DWORD /d 0x5 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{18DF081C-E8AD-4283-A596-FA578C2EBDC3}\iexplore" /v Time /t REG_BINARY /d DF070400050018001600220022002F02 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{18DF081C-E8AD-4283-A596-FA578C2EBDC3}\iexplore" /v Blocked /t REG_DWORD /d 0x5 /f

::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{3A2D5EBA-F86D-4BD3-A177-019765996711}\iexplore" /v Count /t REG_DWORD /d 0x5 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{3A2D5EBA-F86D-4BD3-A177-019765996711}\iexplore" /v Time /t REG_BINARY /d DF070400050018001600220022002F02 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{3A2D5EBA-F86D-4BD3-A177-019765996711}\iexplore" /v Blocked /t REG_DWORD /d 0x5 /f

::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{761497BB-D6F0-462C-B6EB-D4DAF1D92D43}\iexplore" /v Count /t REG_DWORD /d 0x5 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{761497BB-D6F0-462C-B6EB-D4DAF1D92D43}\iexplore" /v Time /t REG_BINARY /d DF070400050018001600220022002F02 /f

::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{761497BB-D6F0-462C-B6EB-D4DAF1D92D43}" /v Flags /t REG_DWORD /d 0x400 /f

::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{AE7CD045-E861-484F-8273-0445EE161910}\iexplore" /v Count /t REG_DWORD /d 0x5 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{AE7CD045-E861-484F-8273-0445EE161910}\iexplore" /v Time /t REG_BINARY /d DF070400050018001600220022002F02 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{AE7CD045-E861-484F-8273-0445EE161910}\iexplore" /v Blocked /t REG_DWORD /d 0x5 /f

::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{AF949550-9094-4807-95EC-D1C317803333}\iexplore" /v Count /t REG_DWORD /d 0x5 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{AF949550-9094-4807-95EC-D1C317803333}\iexplore" /v Time /t REG_BINARY /d DF070400050018001600220022002F02 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{AF949550-9094-4807-95EC-D1C317803333}\iexplore" /v Blocked /t REG_DWORD /d 0x5 /f

::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{DBC80044-A445-435B-BC74-9C25C1C588A9}\iexplore" /v Count /t REG_DWORD /d 0x5 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{DBC80044-A445-435B-BC74-9C25C1C588A9}\iexplore" /v Time /t REG_BINARY /d DF070400050018001600220022002F02 /f

::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{DBC80044-A445-435B-BC74-9C25C1C588A9}" /v Flags /t REG_DWORD /d 0x400 /f

::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{F4971EE7-DAA0-4053-9964-665D8EE6A077}\iexplore" /v Count /t REG_DWORD /d 0x5 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{F4971EE7-DAA0-4053-9964-665D8EE6A077}\iexplore" /v Time /t REG_BINARY /d DF070400050018001600220022002F02 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{F4971EE7-DAA0-4053-9964-665D8EE6A077}\iexplore" /v Blocked /t REG_DWORD /d 0x5 /f







::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v Flags /t REG_DWORD /d 0x43 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\uhs.com" /v * /t REG_DWORD /d 0x2 /f
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\uhs.com\*.int" /v * /t REG_DWORD /d 0x2 /f

::reg add "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v Flags /t REG_DWORD /d 0x43 /f
::reg add "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\EscDomains\uhs.com" /v * /t REG_DWORD /d 0x2 /f
::reg add "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\EscDomains\uhs.com\*.int" /v * /t REG_DWORD /d 0x2 /f

IF "%KIT%" NEQ "JavaSoft\Java Runtime Environment" GOTO 64IE
FOR /F "usebackq skip=2 tokens=3" %%A IN (`reg query "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment" /v BrowserJavaVersion`) do reg add "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Plug-in\%%A" /v UseJava2IExplorer /t REG_DWORD /d 0x1 /f
echo 32bit

gpupdate /force /target:computer
pause

exit