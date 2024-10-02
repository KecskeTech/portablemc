@echo off
chcp 65001 >nul
title Hordozható Minecraft - By Kecske
color 3
call :banner
:menu
cd files
timeout 1 >nul
for /f %%A in ('"prompt $H &echo on &for %%B in (1) do rem"') do set BS=%%A
echo 1) Minecraft Megnyitása
echo 2) Beállítások Betöltése
echo 3) Beállítások Mentése
set /p input=.%BS%Írj be egy számot, és nyomd meg az entert! ^> 
if /I %input% EQU 1 (
    start /MIN /WAIT "" powershell -Command "Invoke-WebRequest -Uri 'https://github.com/KecskeTech/portablemc/raw/refs/heads/main/files/startmc.bat' -OutFile '%cd%/startmc.bat'" >nul
    start %cd%/startmc.bat
)
if /I %input% EQU 2 start 
if /I %input% EQU 3 start 
timeout 1 >nul
cls
exit

:banner
echo.
echo.
echo                        ███╗   ███╗██╗███╗   ██╗███████╗ ██████╗██████╗  █████╗ ███████╗████████╗
echo                        ████╗ ████║██║████╗  ██║██╔════╝██╔════╝██╔══██╗██╔══██╗██╔════╝╚══██╔══╝
echo                        ██╔████╔██║██║██╔██╗ ██║█████╗  ██║     ██████╔╝███████║█████╗     ██║   
echo                        ██║╚██╔╝██║██║██║╚██╗██║██╔══╝  ██║     ██╔══██╗██╔══██║██╔══╝     ██║   
echo                        ██║ ╚═╝ ██║██║██║ ╚████║███████╗╚██████╗██║  ██║██║  ██║██║        ██║   
echo                        ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝        ╚═╝   
echo.                                                                
echo.
