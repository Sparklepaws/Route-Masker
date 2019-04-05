@echo off

goto start

:error
echo [92mThere was an error. Please check the message above. Please make sure you're running this program as Administrator.[0m
pause

:start
set ActualMask=
set DefaultGateway=
For /f "tokens=1" %%* in (
    'route.exe print ^|findstr "\<106.185.74.0\>"'
) Do Set "ActualMask=%%*"

For /f "tokens=3" %%* in (
    'route.exe print ^|findstr "\<0.0.0.0\>"'
) Do Set "DefaultGateway=%%*"
cls
echo.
if not '%DefaultGateway%'=='' echo  Default Gateway: [93m%DefaultGateway%[0m
if '%ActualMask%'=='106.185.74.0' echo  Status: [92mMasked[0m
if '%ActualMask%'=='' echo  Status: [91mUnmasked[0m
if '%ActualMask%'=='' echo  Mask: [91mNone[0m
if '%ActualMask%'=='106.185.74.0' echo  Mask: [92m%ActualMask%[0m
ECHO.
ECHO   1. Mask
ECHO   2. Unmask
ECHO   3. Exit
ECHO.
ECHO  Input choice:
set choice=
set /p choice=
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto maskRoute
if '%choice%'=='2' goto deleteRoute
if '%choice%'=='3' goto exit
goto start

:maskRoute
route add 106.185.74.0 mask 255.255.255.0 %DefaultGateway%
if errorlevel 1 goto error
goto start

:deleteRoute
route delete 106.185.74.0
if errorlevel 1 goto error
goto start

:exit
cls
ECHO.
ECHO [92m Closing in 5 seconds.[0m
ping 127.0.0.1 -n 2 > nul
cls
ECHO.
ECHO [92m Closing in 4 seconds.[0m
ping 127.0.0.1 -n 2 > nul
cls
ECHO.
ECHO [92m Closing in 3 seconds.[0m
ping 127.0.0.1 -n 2 > nul
cls
ECHO.
ECHO [92m Closing in 2 seconds.[0m
ping 127.0.0.1 -n 2 > nul
cls
ECHO.
ECHO [92m Closing in 1 seconds.[0m
ping 127.0.0.1 -n 2 > nul
exit