@echo off
set interface=Ethernet
rem Please set interface variable to the correct adaptor name (check the names by using ipconfig /all)

echo Current DNS Settings:
netsh int ip show dnsservers name="%interface%" | find "."
echo,
echo 0: exit
echo 1: clear dns (Automatic, DHCP)
echo 2: set shecan.ir (178.22.122.100 - 185.51.200.2)
echo 3: set electro (78.157.42.100 - 78.157.42.101)
echo 4: set google (8.8.8.8 - 8.8.4.4)
echo 5: set cloudflare (1.1.1.1 - 1.0.0.1)
echo,

if [%1]==[] (
set /p op=Enter a number: 
) else (
set op=%1
echo Enter a number: %1
)
echo,

if %op%==0 (
exit 0
) else if %op%==1 (
netsh int ip set dns "%interface%" source=dhcp validate=no >nul
) else if %op%==2 (
netsh int ip set dns "%interface%" source=dhcp validate=no >nul
netsh int ip add dns name="%interface%" addr=178.22.122.100 index=1 validate=no >nul
netsh int ip add dns name="%interface%" addr=185.51.200.2 index=2 validate=no >nul
) else if %op%==3 (
netsh int ip set dns "%interface%" source=dhcp validate=no >nul
netsh int ip add dns name="%interface%" addr=78.157.42.100 index=1 validate=no >nul
netsh int ip add dns name="%interface%" addr=78.157.42.101 index=2 validate=no >nul
) else if %op%==4 (
netsh int ip set dns "%interface%" source=dhcp validate=no >nul
netsh int ip add dns name="%interface%" addr=8.8.8.8 index=1 validate=no >nul
netsh int ip add dns name="%interface%" addr=8.8.4.4 index=2 validate=no >nul
) else if %op%==5 (
netsh int ip set dns "%interface%" source=dhcp validate=no >nul
netsh int ip add dns name="%interface%" addr=1.1.1.1 index=1 validate=no >nul
netsh int ip add dns name="%interface%" addr=1.0.0.1 index=2 validate=no >nul
) else (
echo Wrong Input! Exiting...
pause
exit 0
)

if %errorLevel%== 0 (
echo dns is changed successfully! clearing dns cache...
ipconfig /flushdns >nul
nbtstat -R >nul
echo Current DNS Settings:
netsh interface ip show dnsservers name="%interface%" | find "."
echo,
pause
) else (
rem run dns.bat as admin
powershell -command "Start-Process %~nx0 -Verb runas -ArgumentList %op%" >nul
)