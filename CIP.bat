@echo OFF
cls
color 0A

set netname="Wi-Fi"

echo Current IP address ^& DNS are:
netsh interface ip show addresses name=%netname%
netsh interface ip show dns name=%netname%

echo Set IP address of Wi-Fi network adapter.
echo.  
echo [1] - Private IP: Press 1
echo.  
echo [2] - DHCP IP: Press 2
echo. 
echo [0] - Quit: Press 0

echo. 
set /p KEY= Your choice is:  
if %KEY% == 1 goto ONE  
if %KEY% == 2 goto TWO  
if %KEY% == 0 exit
if not %KEY% == 1 (if not %KEY% == 2 goto QUIT)

:ONE
set ip=10.112.1.198
set subnetmask=255.255.255.0
set gateway=10.112.1.2
set dns1=10.112.1.2
set dns2=223.5.5.5

echo Setting IP to private. Please wait for a few seconds......
netsh interface ip set address name=%netname% source=static addr=%ip% mask=%subnetmask% gateway=%gateway% gwmetric=1
netsh interface ip set dns name=%netname% source=static addr=%dns1% register=primary validate=no
REM netsh interface ip add dns %netname%  %dns2%
timeout /T 5
echo Private IP is set done.
echo.
echo Current IP address ^& DNS are:
netsh interface ip show addresses name=%netname%
netsh interface ip show dns name=%netname%
pause
exit

:TWO
echo Setting IP to DHCP. Please wait for a few seconds......
netsh int ip set addr name="%netname%" source=dhcp
netsh int ip set dns name="%netname%" source=dhcp
timeout /T 5
echo DHPC IP is set done.
echo.
echo Current IP address ^& DNS are:
netsh interface ip show addresses name=%netname%
netsh interface ip show dns name=%netname%
pause
exit

:QUIT
echo Your input is wrong, please try me later. Bye!
pause
exit
