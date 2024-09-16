@echo off
setlocal

:: Set paths
set "FILE_DIR=%cd%\files"
set "PRISM_FILE=%FILE_DIR%\prism84"
set "DOWNLOAD_URL=https://github.com/PrismLauncher/PrismLauncher/releases/download/8.4/PrismLauncher-Windows-MinGW-w64-Portable-8.4.zip"
set "ZIP_FILE=%FILE_DIR%\PrismLauncher.zip"
set "PRISM_FOLDER=%FILE_DIR%\prism"

:: Check if prism84 file exists
if exist "%PRISM_FILE%" (
    echo A prism launcher már le van töltve, indítás
    goto start
) else (
    echo A Prism Launcher nincs még letöltve. Telepítés indul...
)

:: Create files directory if not exists
if not exist "%FILE_DIR%" (
    mkdir "%FILE_DIR%"
)

:: Download the file
echo Letöltés...
bitsadmin /transfer "PrismLauncherDownload" "%DOWNLOAD_URL%" "%ZIP_FILE%"

:: Unzip the downloaded file
echo Prism Launcher kicsomagolása...
powershell -command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%PRISM_FOLDER%'"

:: Create the marker file "prism84"
echo Creating marker file...
echo. > "%PRISM_FILE%"

:start
echo Starting the application or process...
start %FILE_DIR% prismlauncher.exe


pause
