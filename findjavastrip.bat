@ECHO off
::gpupdate /force /target:computer

taskkill /f /im java.exe






:Commands
taskkill /f /im java.exe
\\uhs61927\jdk\keytool -importcert -trustcacerts -keystore "C:\Program Files\Java\jre7\lib\security\cacerts" -storepass "changeit" -file "\\uhs61927\jdk\caroot.cer" -noprompt
if not exist "%windir%\Sun\Java\Deployment\" md "%windir%\Sun\Java\Deployment\"
copy "\\uhs61927\jdk\DeploymentRuleSet.jar" %windir%\Sun\Java\Deployment\ /Y



FOR /F "usebackq skip=2 tokens=3" %%A IN (`reg query "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment" /v BrowserJavaVersion`) do reg add "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Plug-in\%%A" /v UseJava2IExplorer /t REG_DWORD /d 0x1 /f
echo 32bit


exit