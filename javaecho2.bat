@echo off
::reg query "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment" /v CurrentVersion> jversion.txt
FOR /F "usebackq skip=2 tokens=3" %%A IN ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment" /v CurrentVersion') do (
FOR /F "usebackq skip=2 tokens=3,4" %%B IN ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment\%%A" /v JavaHome') do (
set varbl=%%B %%C
echo %varbl%
pause
\\uhs61927\jdk\keytool -importcert -keystore "%varbl%\lib\security\cacerts" -storepass "changeit" -file "\\uhs61927\jdk\caroot.cer" -noprompt
copy "\\uhs61927\jdk\DeploymentRuleSet.jar" C:\Windows\Sun\Java\Deployment\
))
