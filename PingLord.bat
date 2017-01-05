REM This section used for colorizing program
@echo off
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do     rem"') do (
  set "DEL=%%a"
)

:SPTcreds
REM this section used to prompt for IP address which is required to do any pings
mode con: cols=60 lines=23
title Store Ping Tool v2
cls
echo.
echo.
echo     ------------------------------
echo.
call :colorEcho 0f "      STORE PING TOOL"
call :colorEcho 08 " v2"
echo.
call :colorEcho 08 "        Written by David Enos"
echo.
call :colorEcho 08 "                   Mark Laxmeter"
echo.
echo.
call :colorEcho 08 "      BUGS AND REQUESTS"
echo.
call :colorEcho 08 "        mark.laxmeter@atos.net"
echo.
echo.
echo     ------------------------------

:allover
echo.
echo    STORE IP ADDRESS ENTRY
echo.
call :colorEcho 0E "    Enter ONLY the first 3 octets of the store IP address" 
echo.
echo       Do not use the final dot (i.e 10.1.1)
echo.
echo       Right-click to paste IP address or type manually
echo       Type MORE for a list of shortcuts
echo.
set /P ip1="----* Store IP: "


REM This will check for invalid IP addresses
ECHO %ip1%> ip.tmp
FOR %%? IN (ip.tmp) DO ( SET /A iplength=%%~z? -2 )
del ip.tmp
if %ip1% EQU far1 (
	goto :usebench1ip
)
if %ip1% EQU far2 (
	goto :usebench2ip
)
if %ip1% EQU far3 (
	goto :usebench3ip
)
if %ip1% EQU broken (
	goto :usebrokenip
)
if %ip1% EQU more (
	goto :iphelp
)
if %ip1% EQU FAR1 (
	goto :usebench1ip
)
if %ip1% EQU FAR2 (
	goto :usebench2ip
)
if %ip1% EQU FAR3 (
	goto :usebench3ip
)
if %ip1% EQU BROKEN (
	goto :usebrokenip
)
if %ip1% EQU MORE (
	goto :iphelp
)
if %iplength% gtr 10 (
	cls
	echo.
	echo  IP address provided has 4 octets/is too long
	echo.
	echo    Remove 4th octet and try again
	echo    Correct format: ###.###.### 
	echo                  [remove last .##]
	echo.
	timeout /t -1
	cls
	goto allover
)
if %iplength% lss 9 (
	cls
	echo.
	echo  IP address is too short
	echo.
	echo    Try again with correct format
	echo    Correct format: ###.###.### 
	echo                  [remove last .##]
	echo.
	timeout /t -1
	cls
	goto allover
)
goto mainmenu

REM These sections set the mapping for IP shortcuts
REM remember to add a hook at the IP entry menu if 
REM an IP is added to this list
:usebench1ip
set ip1=10.196.65
goto mainmenu
:usebench2ip
set ip1=10.196.65
goto mainmenu
:usebench3ip
set ip1=10.196.65
goto mainmenu
:usebrokenip
set ip1=00.000.00
goto mainmenu

:iphelp
cls
mode con: cols=60 lines=22
echo.
echo   IP ADDRESS SHORTCUTS
echo.
echo   SHORTCUT   DESCRIPTION                    IP ADDRESS
echo   --------   -------------------------      ----------
echo    far1      Bench 1 at Fargo               10.196.65
echo    far2      Bench 2 at Fargo (not set up)  10.196.65
echo    far3      Bench 3 at Fargo (not set up)  10.196.65
echo    broken    Simulate 'Broadband Down'      00.000.00
echo.
echo.
echo  Press any key to go back
pause >nul
goto SPTcreds

REM code for creating the main menu, also verifies IP
:mainmenu
title SPTv2 - Main Menu
cls
mode con: cols=45 lines=31
echo.
echo  -------------------------------------------
echo.
echo.
echo                  MAIN MENU 
echo            Please select option:
echo.
echo                  Store IP:
echo                  %ip1%
echo.
echo.
call :colorEcho 0e "    P - GET STORE PULSE (quick check)
echo.
echo.
call :colorEcho 0f "    1 - CHECK ALL DEVICES ONLINE"
echo.
echo       2 - Check POS only 
echo       3 - Check BOH only 
echo       4 - Check QSR only 
echo       5 - Check Net only (Rtr,Swt,Wifi) 
echo       6 - Check HME only
echo.  
call :colorEcho 0f "    8 - SINGLE DEVICE (CONTINUOUS PING)"
echo.
echo.
call :colorEcho 0f "    9 - PING ROUGE DEVICES .49 - .70
echo. 
echo.
call :colorEcho 0f "    0 - ENTER NEW STORE NUMBER 
echo.
echo       Q - Quit    
echo.
echo  -------------------------------------------
echo.
set /p mmchoice=-* Make a selection:
if not '%mmchoice%'=='' set mmchoice=%mmchoice:~0,1%
if '%mmchoice%'=='1' goto checkALL
if '%mmchoice%'=='2' goto checkPOS
if '%mmchoice%'=='3' goto checkBOH
if '%mmchoice%'=='4' goto checkQSR
if '%mmchoice%'=='5' goto checkNET
if '%mmchoice%'=='6' goto checkHME
if '%mmchoice%'=='8' goto pingdevice
if '%mmchoice%'=='9' goto rouge1
if '%mmchoice%'=='0' cls && mode con: cols=60 lines=11 && title SPTv2 - IP Address Entry && goto allover
if '%mmchoice%'=='q' exit
if '%mmchoice%'=='P' goto PULSE
if '%mmchoice%'=='p' goto PULSE



REM this giant section pings everything in the store excl rogue devices
:checkALL
:startover2
:rrepeatstore2
title SPTv2 - Store Check - RUNNING
cls
mode con: cols=60 lines=71
echo DEVICE CHECK
echo.
echo CHECKING ROUTER, POS, OCB, BOH PC, HME TIMER, 
echo AIRCARD, AIRTIGHT AND HP MANAGED SWITCH
echo.
echo Allow 60 seconds for Device Check to run
echo Please wait...
echo.
echo CHECKING ROUTER...
echo.
ping %ip1%.2 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	title SPTv2 - Store Check - BROADBAND DOWN
	echo.
	call :colorEcho e4 "#                         #"
	echo.
	call :colorEcho e4 "#     BROADBAND DOWN      #"
	echo.
	call :colorEcho e4 "#                         #"
	echo.
	echo.
	pause
	goto mainmenu
) else (
	call :colorEcho 0a "ROUTER ONLINE"
	echo.
)
echo _______________________________________
echo CHECKING POS...
ping %ip1%.21 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo.
	call :colorEcho 07 "POS 1"
	call :colorEcho 0c " OFFLINE"
) else (
	echo.
	call :colorEcho 07 "POS 1"
	call :colorEcho 02 " ONLINE"
)

ping %ip1%.22 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo.
	call :colorEcho 07 "POS 2"
	call :colorEcho 0c " OFFLINE"
) else (
	echo.
	call :colorEcho 07 "POS 2"
	call :colorEcho 02 " ONLINE"
)

ping %ip1%.23 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo.
	call :colorEcho 07 "POS 3"
	call :colorEcho 0c " OFFLINE or not present"
) else (
	echo.
	call :colorEcho 07 "POS 3"
	call :colorEcho 02 " ONLINE"
)
ping %ip1%.24 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo.
	call :colorEcho 07 "POS 4"
	call :colorEcho 0c " OFFLINE or not present"
) else (
	echo.
	call :colorEcho 07 "POS 4"
	call :colorEcho 02 " ONLINE"
)
ping %ip1%.25 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo.
	call :colorEcho 07 "POS 5"
	call :colorEcho 0c " OFFLINE or not present"
) else (
	echo.
	call :colorEcho 07 "POS 5"
	call :colorEcho 02 " ONLINE"
)
ping %ip1%.26 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo.
	call :colorEcho 07 "POS 6"
	call :colorEcho 0c " OFFLINE or not present"
) else (
	echo.
	call :colorEcho 07 "POS 6"
	call :colorEcho 02 " ONLINE"
)
echo.
echo _______________________________________

echo CHECKING OCB...
echo.

ping %ip1%.8 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo OCB OFFLINE OR NON-HYPERVIEW
) else (
	echo OCB ONLINE
)
echo _______________________________________

echo CHECKING QSR'S...
echo.
ping %ip1%.31 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * QSR1 offline or not present
) else (
	echo QSR1 ONLINE
)
ping %ip1%.32 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * QSR2 offline or not present
) else (
	echo QSR2 ONLINE
)
ping %ip1%.33 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * QSR3 offline or not present
) else (
	echo QSR3 ONLINE
)
ping %ip1%.34 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * QSR4 offline or not present
) else (
	echo QSR4 ONLINE
)
ping %ip1%.35 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * QSR5 offline or not present
) else (
	echo QSR5 ONLINE
)
ping %ip1%.36 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * QSR6 offline or not present
) else (
	echo QSR6 ONLINE
)
ping %ip1%.37 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * QSR7 offline or not present
) else (
	echo QSR7 ONLINE
)
ping %ip1%.38 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * QSR8 offline or not present
) else (
	echo QSR8 ONLINE
)
echo _______________________________________
echo CHECKING BOH PC...
echo.

ping %ip1%.11 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * BOH Offline or is not TACO/eR
) else (
	echo BOH PC ONLINE
)
echo _______________________________________
echo CHECKING AIRCARD AND AIRTIGHT...
echo.

ping %ip1%.3 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * Aircard Offline/not present
) else (
	echo AIRCARD ONLINE
)

ping %ip1%.133 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * Airtight Offline/not present
) else (
	echo AIRTIGHT ONLINE
)
echo _______________________________________
echo CHECKING HME TIMER...
echo - HME may not ping on all addresses
echo.

ping %ip1%.41 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * HME Timer not found on .41
) else (
	echo HME TIMER ONLINE
)
ping %ip1%.42 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * HME Timer not found on .42
) else (
	echo HME TIMER ONLINE
)
ping %ip1%.43 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * HME Timer not found on .43
) else (
	echo HME TIMER ONLINE
)
ping %ip1%.157 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * HME Timer CU not found on .157
) else (
	echo HME TIMER ONLINE
)
echo _______________________________________
echo CHECKING IF SITE USES HP MANAGED SWITCH...
echo.
ping %ip1%.150 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * HP switch down/nonmanaged switch
) else (
	echo HP SWITCH UP
)
goto pingDone

REM lightweight version of entire store pinger
:PULSE
:startoverQP
:rrepeatstoreQP
title SPTv2 - Store Pulse - RUNNING
cls
mode con: cols=60 lines=70
call :colorEcho 0e "STORE PULSE CHECK"
echo.
echo..
echo Allow 15 seconds for Pulse Check to run
echo Please wait...
echo.
echo CHECKING ROUTER...
echo.
ping %ip1%.2 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo.
	call :colorEcho e4 "#                         #"
	echo.
	call :colorEcho e4 "#     BROADBAND DOWN      #"
	echo.
	call :colorEcho e4 "#                         #"
	echo.
	pause
	goto mainmenu
) else (
	call :colorEcho 0a "ROUTER ONLINE"
	echo.
)
echo _______________________________________
echo CHECKING POS...
ping %ip1%.21 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo.
	call :colorEcho 07 "POS 1"
	call :colorEcho 0c " OFFLINE"
) else (
	echo.
	call :colorEcho 07 "POS 1"
	call :colorEcho 02 " ONLINE"
)

ping %ip1%.22 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo.
	call :colorEcho 07 "POS 2"
	call :colorEcho 0c " OFFLINE"
) else (
	echo.
	call :colorEcho 07 "POS 2"
	call :colorEcho 02 " ONLINE"
)

ping %ip1%.23 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo.
	call :colorEcho 07 "POS 3"
	call :colorEcho 0c " OFFLINE or not present"
) else (
	echo.
	call :colorEcho 07 "POS 3"
	call :colorEcho 02 " ONLINE"
)
ping %ip1%.24 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo.
	call :colorEcho 07 "POS 4"
	call :colorEcho 0c " OFFLINE or not present"
) else (
	echo.
	call :colorEcho 07 "POS 4"
	call :colorEcho 02 " ONLINE"
)
echo.
echo _______________________________________

echo CHECKING QSR'S...
echo.
ping %ip1%.31 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * QSR1 offline or not present
) else (
	echo QSR1 ONLINE
)
ping %ip1%.32 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * QSR2 offline or not present
) else (
	echo QSR2 ONLINE
)
ping %ip1%.33 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * QSR3 offline or not present
) else (
	echo QSR3 ONLINE
)
ping %ip1%.34 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * QSR4 offline or not present
) else (
	echo QSR4 ONLINE
)
ping %ip1%.35 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * QSR5 offline or not present
) else (
	echo QSR5 ONLINE
)
echo _______________________________________
echo CHECKING BOH PC...
echo.
ping %ip1%.11 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * BOH Offline or is not TACO/eR
) else (
	echo BOH PC ONLINE
)
goto pingDone

REM checks only POS devices
title SPTv2 - Device Check - RUNNING
:checkPOS
echo.
call :colorEcho 0f "CHECKING POS"
echo ...
ping %ip1%.21 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo.
	call :colorEcho 07 "POS 1"
	call :colorEcho 0c " OFFLINE"
) else (
	echo.
	call :colorEcho 07 "POS 1"
	call :colorEcho 02 " ONLINE"
)
ping %ip1%.22 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo.
	call :colorEcho 07 "POS 2"
	call :colorEcho 0c " OFFLINE"
) else (
	echo.
	call :colorEcho 07 "POS 2"
	call :colorEcho 02 " ONLINE"
)
ping %ip1%.23 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo.
	call :colorEcho 07 "POS 3"
	call :colorEcho 0c " OFFLINE or not present"
) else (
	echo.
	call :colorEcho 07 "POS 3"
	call :colorEcho 02 " ONLINE"
)
ping %ip1%.24 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo.
	call :colorEcho 07 "POS 4"
	call :colorEcho 0c " OFFLINE or not present"
) else (
	echo.
	call :colorEcho 07 "POS 4"
	call :colorEcho 02 " ONLINE"
)
ping %ip1%.25 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo.
	call :colorEcho 07 "POS 5"
	call :colorEcho 0c " OFFLINE or not present"
) else (
	echo.
	call :colorEcho 07 "POS 5"
	call :colorEcho 02 " ONLINE"
)
ping %ip1%.26 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo.
	call :colorEcho 07 "POS 6"
	call :colorEcho 0c " OFFLINE or not present"
) else (
	echo.
	call :colorEcho 07 "POS 6"
	call :colorEcho 02 " ONLINE"
)
echo.
goto pingDone


REM checks only QSRs and OCB
title SPTv2 - Device Check - RUNNING
:checkQSR
echo _______________________________________
echo CHECKING QSR'S...
echo.
ping %ip1%.31 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * QSR1 offline or not present
) else (
	echo QSR1 ONLINE
)
ping %ip1%.32 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * QSR2 offline or not present
) else (
	echo QSR2 ONLINE
)
ping %ip1%.33 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * QSR3 offline or not present
) else (
	echo QSR3 ONLINE
)
ping %ip1%.34 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * QSR4 offline or not present
) else (
	echo QSR4 ONLINE
)
ping %ip1%.35 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * QSR5 offline or not present
) else (
	echo QSR5 ONLINE
)
ping %ip1%.36 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * QSR6 offline or not present
) else (
	echo QSR6 ONLINE
)
ping %ip1%.37 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * QSR7 offline or not present
) else (
	echo QSR7 ONLINE
)
ping %ip1%.38 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * QSR8 offline or not present
) else (
	echo QSR8 ONLINE
)
echo _______________________________________
echo CHECKING OCB...
echo.

ping %ip1%.8 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo OCB OFFLINE OR NON-HYPERVIEW
) else (
	echo OCB ONLINE
)
goto pingDone


REM checks only network related devices like router and wifi
:checkNET
title SPTv2 - Device Check - RUNNING
echo CHECKING ROUTER...
echo.
ping %ip1%.2 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	title SPTv2 - Device Check - BROADBAND DOWN
	echo.
	call :colorEcho e4 "#                         #"
	echo.
	call :colorEcho e4 "#     BROADBAND DOWN      #"
	echo.
	call :colorEcho e4 "#                         #"
	echo.
	pause
	goto mainmenu
) else (
	call :colorEcho 0a "ROUTER ONLINE"
	echo.
)
echo _______________________________________
echo CHECKING IF SITE USES HP MANAGED SWITCH...
echo.
ping %ip1%.150 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * HP switch down/nonmanaged switch
) else (
	echo HP SWITCH UP
)
echo _______________________________________
echo CHECKING AIRCARD AND AIRTIGHT...
echo.
ping %ip1%.3 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * Aircard Offline/not present
) else (
	echo AIRCARD ONLINE
)

ping %ip1%.133 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * Airtight Offline/not present
) else (
	echo AIRTIGHT ONLINE
)
goto pingDone


REM checks only BOH 
title SPTv2 - Device Check - RUNNING
:checkBOH
echo _______________________________________
echo CHECKING BOH PC...
echo.
ping %ip1%.11 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * BOH Offline or is not TACO/eR
) else (
	echo BOH PC ONLINE
)
goto pingDone

echo _______________________________________
echo CHECKING HME TIMER...
echo - HME may not ping on all addresses
echo.

ping %ip1%.41 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * HME Timer not found on .41
) else (
	echo HME TIMER ONLINE
)
ping %ip1%.42 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * HME Timer not found on .42
) else (
	echo HME TIMER ONLINE
)
ping %ip1%.43 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * HME Timer not found on .43
) else (
	echo HME TIMER ONLINE
)
ping %ip1%.157 -n 1 -w 1000 | find "TTL=">nul
if errorlevel 1 (
	echo * HME50 Timer CU not found on .157
) else (
	echo HME50 TIMER CU ONLINE
)
goto pingDone


REM this section is triggered on any device check operation finishing
:pingDone
title SPTv2 - Device Check - COMPLETED
echo _______________________________________
echo.
call :colorEcho 1f "#                                #"
echo.
call :colorEcho 1f "#     DEVICE CHECK COMPLETED     #"
echo.
call :colorEcho 1f "#                                #"
echo.
echo.
echo _______________________________________
echo.
call :colorEcho 0e "Post-check options"
echo.
echo.
call :colorEcho 0f "Press 0 to return to main menu"
echo.
echo   Press 1 to start a storewide ping
echo   Press 2 to continuous ping a device
echo   Press 3 to set a different store IP
echo   Press C to open a COMMAND PROMPT
echo   Press X to exit
echo.
set /p choice=* Selection: 
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='0' goto mainmenu
if '%choice%'=='1' goto rrepeatstore2
if '%choice%'=='2' goto pingdevice
if '%choice%'=='3' cls && mode con: cols=60 lines=11 && title SPTv2 - IP Address Entry && goto allover
if '%choice%'=='c' goto cmd
if '%choice%'=='C' goto cmd
if '%choice%'=='X' exit
if '%choice%'=='x' exit

cls
goto pingDone

REM the below sections are the utility sections and dont do device checks



REM Device pinger. Continuous ping specified device on the IP
:pingdevice
mode con: cols=43 lines=27
title SPTv2 - Continuous Pinger
console
cls
echo.
echo          What do you want to ping?
echo.
echo              Available options:
echo.
echo          ***** Single Device *****
echo          *    POS#   QSR#  VF#   *
echo          *   BOH  ROUTER  SWITCH *
echo          *************************
echo.
echo     ********** Device Groups **********
echo     * Device groups open mult windows *
echo     *   POSX  (POS 1-6)               *
echo     *   QSRX  (QSR 1-6)               *
echo     *   VFX   (Verifone POS1-5)       *
echo     *   HME   (HME on .41-.43,.157)   *
echo     *   NETX  (Rtr,Swt,POS1,BOH,QSR1) *
echo     ***********************************
echo.
echo       Press 0 to go to main menu
echo       Press 1 to set a new IP
echo       Press C to close open pings
echo       Press K to time-kill open pings
echo.
set /P choice="---*  SELECTION: "
cls

if '%choice%'=='0' goto :mainmenu
if '%choice%'=='1' goto :allover
if '%choice%'=='c' goto :dpCLEANUP
if '%choice%'=='C' goto :dpCLEANUP
if '%choice%'=='k' goto :dpKILLTIMER
if '%choice%'=='K' goto :dpKILLTIMER
if '%choice%'=='POS1' goto :dpsPOS1
if '%choice%'=='POS2' goto :dpsPOS2
if '%choice%'=='POS3' goto :dpsPOS3
if '%choice%'=='POS4' goto :dpsPOS4
if '%choice%'=='POS5' goto :dpsPOS5
if '%choice%'=='POS6' goto :dpsPOS6
if '%choice%'=='POS7' goto :dpsPOS7
if '%choice%'=='POS8' goto :dpsPOS8
if '%choice%'=='POS9' goto :dpsPOS9
if '%choice%'=='QSR1' goto :dpsQSR1
if '%choice%'=='QSR2' goto :dpsQSR2
if '%choice%'=='QSR3' goto :dpsQSR3
if '%choice%'=='QSR4' goto :dpsQSR4
if '%choice%'=='QSR5' goto :dpsQSR5
if '%choice%'=='QSR6' goto :dpsQSR6
if '%choice%'=='QSR7' goto :dpsQSR7
if '%choice%'=='QSR8' goto :dpsQSR8
if '%choice%'=='QSR9' goto :dpsQSR9
if '%choice%'=='VF1' goto :dpsVF1
if '%choice%'=='VF2' goto :dpsVF2
if '%choice%'=='VF3' goto :dpsVF3
if '%choice%'=='VF4' goto :dpsVF4
if '%choice%'=='VF5' goto :dpsVF5
if '%choice%'=='vf1' goto :dpsVF1
if '%choice%'=='vf2' goto :dpsVF2
if '%choice%'=='vf3' goto :dpsVF3
if '%choice%'=='vf4' goto :dpsVF4
if '%choice%'=='vf5' goto :dpsVF5
if '%choice%'=='pos1' goto :dpsPOS1
if '%choice%'=='pos2' goto :dpsPOS2
if '%choice%'=='pos3' goto :dpsPOS3
if '%choice%'=='pos4' goto :dpsPOS4
if '%choice%'=='pos5' goto :dpsPOS5
if '%choice%'=='pos6' goto :dpsPOS6
if '%choice%'=='pos7' goto :dpsPOS7
if '%choice%'=='pos8' goto :dpsPOS8
if '%choice%'=='pos9' goto :dpsPOS9
if '%choice%'=='qsr1' goto :dpsQSR1
if '%choice%'=='qsr2' goto :dpsQSR2
if '%choice%'=='qsr3' goto :dpsQSR3
if '%choice%'=='qsr4' goto :dpsQSR4
if '%choice%'=='qsr5' goto :dpsQSR5
if '%choice%'=='qsr6' goto :dpsQSR6
if '%choice%'=='qsr7' goto :dpsQSR7
if '%choice%'=='qsr8' goto :dpsQSR8
if '%choice%'=='qsr9' goto :dpsQSR9
if '%choice%'=='BOH' goto :dpsBOH
if '%choice%'=='ROUTER' goto :dpsROUTER
if '%choice%'=='SWITCH' goto :dpsSWITCH
if '%choice%'=='POSX' goto :dpgPOSX
if '%choice%'=='QSRX' goto :dpgQSRX
if '%choice%'=='HME' goto :dpgHME
if '%choice%'=='NETX' goto :dpgNETX
if '%choice%'=='VFX' goto :dpgVFX
if '%choice%'=='boh' goto :dpsBOH
if '%choice%'=='router' goto :dpsROUTER
if '%choice%'=='switch' goto :dpsSWITCH
if '%choice%'=='posx' goto :dpgPOSX
if '%choice%'=='qsrx' goto :dpgQSRX
if '%choice%'=='hme' goto :dpgHME
if '%choice%'=='netx' goto :dpgNETX
if '%choice%'=='vfx' goto :dpgVFX

REM the below dps and dpg sections open a new cmd window pinging
REM the requested device(s) with the -t flag

REM POS cmd windows
:dpsPOS1
start cmd /k "color 0E && title POS 1 PING && ping %ip1%.21 -t"
goto pingdevice
:dpsPOS2
start cmd /k "color 0E && title POS 2 PING && ping %ip1%.22 -t"
goto pingdevice
:dpsPOS3
start cmd /k "color 0E && title POS 3 PING && ping %ip1%.23 -t"
goto pingdevice
:dpsPOS4
start cmd /k "color 0E && title POS 4 PING && ping %ip1%.24 -t"
goto pingdevice
:dpsPOS5
start cmd /k "color 0E && title POS 5 PING && ping %ip1%.25 -t"
goto pingdevice
:dpsPOS6
start cmd /k "color 0E && title POS 6 PING && ping %ip1%.26 -t"
goto pingdevice
:dpsPOS7
start cmd /k "color 0E && title POS 7 PING && ping %ip1%.27 -t"
goto pingdevice
:dpsPOS8
start cmd /k "color 0E && title POS 8 PING && ping %ip1%.28 -t"
goto pingdevice
:dpsPOS9
start cmd /k "color 0E && title POS 9 PING && ping %ip1%.29 -t"
goto pingdevice

REM QSR cmd windows
:dpsQSR1
start cmd /k "color 0D && title QSR 1 PING && ping %ip1%.31 -t"
goto pingdevice
:dpsQSR2
start cmd /k "color 0D && title QSR 2 PING && ping %ip1%.32 -t"
goto pingdevice
:dpsQSR3
start cmd /k "color 0D && title QSR 3 PING && ping %ip1%.33 -t"
goto pingdevice
:dpsQSR4
start cmd /k "color 0D && title QSR 4 PING && ping %ip1%.34 -t"
goto pingdevice
:dpsQSR5
start cmd /k "color 0D && title QSR 5 PING && ping %ip1%.35 -t"
goto pingdevice
:dpsQSR6
start cmd /k "color 0D && title QSR 6 PING && ping %ip1%.36 -t"
goto pingdevice
:dpsQSR7
start cmd /k "color 0D && title QSR 7 PING && ping %ip1%.37 -t"
goto pingdevice
:dpsQSR8
start cmd /k "color 0D && title QSR 8 PING && ping %ip1%.38 -t"
goto pingdevice
:dpsQSR9
start cmd /k "color 0D && title QSR 9 PING && ping %ip1%.39 -t"
goto pingdevice

REM ping verifone devices cmd

:dpsVF1
start cmd /k "title VERIFONE POS1 PING && ping %ip1%.15 -t"
goto pingdevice
:dpsVF2
start cmd /k "title VERIFONE POS2 PING && ping %ip1%.16 -t"
goto pingdevice
:dpsVF3
start cmd /k "title VERIFONE POS3 Err. && echo POS 3 DOES NOT TAKE CREDIT TRANSACTIONS && echo Select a different Verifone POS"
goto pingdevice
:dpsVF4
start cmd /k "title VERIFONE POS4 PING && ping %ip1%.18 -t"
goto pingdevice
:dpsVF5
start cmd /k "title VERIFONE POS5 PING && ping %ip1%.19 -t"
goto pingdevice

REM Other single device cmd windows

:dpsBOH
start cmd /k "color 0D && title BOH PING && ping %ip1%.11 -t"
goto pingdevice
:dpsROUTER
start cmd /k "color 0D && title ROUTER PING && ping %ip1%.1 -t"
goto pingdevice
:dpsSWITCH
start cmd /k "color 0D && title SWITCH PING && ping %ip1%.150 -t"
goto pingdevice

REM ping groups of devices, opening several command windows at once
:dpgPOSX
title SPTv2 - Continuous Pinger - INITIALIZING PINGS
start cmd /k "color 0E && title POS 1 PING && ping %ip1%.21 -t"
start cmd /k "color 0E && title POS 2 PING && ping %ip1%.22 -t"
start cmd /k "color 0E && title POS 3 PING && ping %ip1%.23 -t"
start cmd /k "color 0E && title POS 4 PING && ping %ip1%.24 -t"
start cmd /k "color 0E && title POS 5 PING && ping %ip1%.25 -t"
start cmd /k "color 0E && title POS 6 PING && ping %ip1%.26 -t"
goto pingdevice

:dpgQSRX
title SPTv2 - Continuous Pinger - INITIALIZING PINGS
start cmd /k "color 0D && title QSR 1 PING && ping %ip1%.31 -t"
start cmd /k "color 0D && title QSR 2 PING && ping %ip1%.32 -t"
start cmd /k "color 0D && title QSR 3 PING && ping %ip1%.33 -t"
start cmd /k "color 0D && title QSR 4 PING && ping %ip1%.34 -t"
start cmd /k "color 0D && title QSR 5 PING && ping %ip1%.35 -t"
start cmd /k "color 0D && title QSR 6 PING && ping %ip1%.36 -t"
goto pingdevice

:dpgHME
title SPTv2 - Continuous Pinger - INITIALIZING PINGS
start cmd /k "color 0D && title HME .41 PING && ping %ip1%.41 -t"
start cmd /k "color 0D && title HME .41 PING && ping %ip1%.42 -t"
start cmd /k "color 0D && title HME .41 PING && ping %ip1%.43 -t"
start cmd /k "color 0D && title HME .157 (CU) PING && ping %ip1%.157 -t"
goto pingdevice

:dpgVFX
title SPTv2 - Continuous Pinger - INITIALIZING PINGS
start cmd /k "title VERIFONE POS1 PING && ping %ip1%.15 -t"
start cmd /k "title VERIFONE POS2 PING && ping %ip1%.16 -t"
start cmd /k "title VERIFONE POS4 PING && ping %ip1%.18 -t"
start cmd /k "title VERIFONE POS5 PING && ping %ip1%.19 -t"
goto pingdevice

REM ping netx group incl network infrastructure and POS1,QSR1,BOH
:dpgNETX
title SPTv2 - Continuous Pinger - INITIALIZING PINGS
start cmd /k "color 0D && title QSR 1 PING && ping %ip1%.31 -t"
start cmd /k "color 0E && title POS 1 PING && ping %ip1%.21 -t"
start cmd /k "color 0D && title ROUTER PING && ping %ip1%.1 -t"
start cmd /k "color 0D && title SWITCH PING && ping %ip1%.150 -t"
start cmd /k "color 0D && title BOH PING && ping %ip1%.11 -t"
goto pingdevice


REM closes all ping windows that are open
REM note, may need to be changed later. Currently closes
REM any cmd window that has PING in the title
REM that was created with the title command
REM Will need to change if it closes undesired windows

REM does not appear to interfere with a ping made outside of SPT
REM eg ping xx.xxx.xx.xx -t in user-created cmd

REM does not appear to interfere with existing SPT windows
REM or other SPT instances
:dpCLEANUP
for /f "tokens=2 delims=," %%a in ('
    tasklist /fi "imagename eq cmd.exe" /v /fo:csv /nh 
    ^| findstr /r /c:".*PING[^,]*$"
') do taskkill /pid %%a
goto pingdevice


REM closes all ping windows that are open automatically
REM different from CLEANUP as you can set to autokill after 
REM some time instead of having to manually kill

REM not implemented yet. will have a popup cmd that stays
REM open during other pings with tools
REM may need to make another bat for this
REM will use use a prompt for seconds to leave open
REM will have a countdown from specified seconds then
REM will use the CLEANUP code to actually kill windows
:dbKILLTIMER
echo.
echo This is not implemented yet.
echo.



REM ping for rogue devices
:rouge1
title SPTv2 - Device Check - RUNNING
cls
echo Pinging for Rouge devices 49-70
echo This may take some time, please wait...
echo If no results appear then there are no alive devices in this range
echo.
@echo off
for /l %%i in (49,1,70) do @ping %ip1%.%%i -n 1 -w 1 | find "Reply"
goto pingDone


REM open a CMD window
:cmd
cls
start cmd /k
goto mainmenu


REM This section used for fabulous colorization
:colorEcho
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1i



