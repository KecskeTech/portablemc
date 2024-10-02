@echo off
color 08
chcp 65001 >nul
title Hordozható Minecraft - By Kecske
setlocal

:variables
set "PRISM_FILE=prism84"
set "DOWNLOAD_URL=https://github.com/PrismLauncher/PrismLauncher/releases/download/8.4/PrismLauncher-Windows-MinGW-w64-Portable-8.4.zip"
set "ZIP_FILE=%cd%/PrismLauncher.zip"
set "PRISM_FOLDER=%cd%/prism"

set "DOCS_DIR=C:/Users/Public/Documents"
set "JAVA_MARKER=C:/Users/Public/Documents/javaV1"
set "JAVA_URL1=https://github.com/KecskeTech/java-pmc/raw/refs/heads/main/OpenJDK8U-jre_x64_windows_hotspot_8u422b05.zip"
set "JAVA_URL2=https://github.com/KecskeTech/java-pmc/raw/refs/heads/main/OpenJDK17U-jre_x64_windows_hotspot_17.0.12_7.zip"
set "JAVA_URL3=https://github.com/KecskeTech/java-pmc/raw/refs/heads/main/OpenJDK21U-jre_x64_windows_hotspot_21.0.4_7.zip"

set "JAVA_ZIP1=%cd%/OpenJDK8U.zip"
set "JAVA_ZIP2=%cd%/OpenJDK17U.zip"
set "JAVA_ZIP3=%cd%/OpenJDK21U.zip"

:checkprisminstall
if exist "%PRISM_FILE%" (
    echo A Prism launcher már telepítve van, a Java-t ellenőrizzük...
    goto java
) else (
    echo A Prism Launcher még nincs letöltve. Telepítés indítása...
)
pause

:downloadprism
echo Prism Launcher letöltése...
bitsadmin /transfer "PrismLauncherDownload" "%DOWNLOAD_URL%" "%ZIP_FILE%" >nul
pause

:unzipprism
echo Prism Launcher kicsomagolása
start /MIN /WAIT "" PowerShell -Command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%PRISM_FOLDER%' -Force" >nul
pause

:createmarker
echo Jelölő file létrehozása...
echo. > "%PRISM_FILE%"

:copyconfig
echo Config másolása
copy /Y "%cd%/prismlauncher.cfg" "%PRISM_FOLDER%"
copy /Y "%cd%/accounts.json" "%PRISM_FOLDER%"
:: Edit maxram based on system ram
:: Get total physical memory in MB
for /f "tokens=2 delims==" %%A in ('wmic computersystem get totalphysicalmemory /value') do set /A RAM_MB=%%A/1024/1024

:: Check for the prismlauncher.cfg file
set "config_path=%cd%\prism\prismlauncher.cfg"
if not exist "%config_path%" (
    echo Nem találtuk meg a configot!
    timeout 3 >nul
    exit /b
)

:: Set memory value based on RAM size
if %RAM_MB% gtr 13000 (
    set RAM_VALUE=8192
) else if %RAM_MB% gtr 10000 (
    set RAM_VALUE=6000
) else if %RAM_MB% gtr 6500 (
    set RAM_VALUE=4096
) else if %RAM_MB% gtr 5500 (
    set RAM_VALUE=3000
) else if %RAM_MB% gtr 3000 (
    set RAM_VALUE=2048
) else (
    echo Not enough RAM to meet the conditions.
    exit /b
)

:: Replace the MaxMemAlloc value in prismlauncher.cfg
(for /f "delims=" %%i in ('type "%config_path%"') do (
    echo %%i | findstr /r "^MaxMemAlloc=" >nul
    if errorlevel 1 (
        echo %%i
    ) else (
        echo MaxMemAlloc=%RAM_VALUE%
    )
)) > "%config_path%.tmp"

:: Replace the old config with the new one
move /y "%config_path%.tmp" "%config_path%"

echo Configuration updated with MaxMemAlloc=%RAM_VALUE%
pause

:java
:: Check for javaV1 marker file
if exist "%JAVA_MARKER%" (
    echo A java már át van másolva... launcher indítása
    goto start
) else (
    echo A java még nincs telepítve, indul a letöltés...
)
pause
:javainstall
echo Java letöltése...
bitsadmin /transfer "Java8dl" "%JAVA_URL1%" "%JAVA_ZIP1%" >nul
bitsadmin /transfer "Java17dl" "%JAVA_URL2%" "%JAVA_ZIP2%" >nul
bitsadmin /transfer "Java21dl" "%JAVA_URL3%" "%JAVA_ZIP3%" >nul
timeout 1 >nul

echo Java kicsomagolása...
start /MIN /WAIT "" PowerShell -Command "Expand-Archive -Path '%JAVA_ZIP1%' -DestinationPath '%DOCS_DIR%' -Force" >nul
start /MIN /WAIT "" PowerShell -Command "Expand-Archive -Path '%JAVA_ZIP2%' -DestinationPath '%DOCS_DIR%' -Force" >nul
start /MIN /WAIT "" PowerShell -Command "Expand-Archive -Path '%JAVA_ZIP3%' -DestinationPath '%DOCS_DIR%' -Force" >nul
timeout 1 >nul

ren "C:\Users\Public\Documents\jdk8u422-b05-jre" "java8"
ren "C:\Users\Public\Documents\jdk-17.0.12+7-jre" "java17"
ren "C:\Users\Public\Documents\jdk-21.0.4+7-jre" "java21"

echo Java jelölő létrehozása...
echo. > "%JAVA_MARKER%"

echo Indítás 3mp múlva!...
timeout 3 >nul

:start
start /I "" %cd%/prism/prismlauncher.exe
exit
:: Add any further launch steps here

pause
