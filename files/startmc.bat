@echo off
chcp 65001
setlocal

:: Set paths
set "PRISM_FILE=prism84"
set "DOWNLOAD_URL=https://github.com/PrismLauncher/PrismLauncher/releases/download/8.4/PrismLauncher-Windows-MinGW-w64-Portable-8.4.zip"
set "ZIP_FILE=PrismLauncher.zip"
set "PRISM_FOLDER=%cd%/prism"

set "DOCS_DIR=C:/Users/Public/Documents"
set "JAVA_MARKER=C:/Users/Public/Documents/javaV1"
set "JAVA_URL1=https://github.com/KecskeTech/java-pmc/raw/refs/heads/main/OpenJDK8U-jre_x64_windows_hotspot_8u422b05.zip"
set "JAVA_URL2=https://github.com/KecskeTech/java-pmc/raw/refs/heads/main/OpenJDK17U-jre_x64_windows_hotspot_17.0.12_7.zip"
set "JAVA_URL3=https://github.com/KecskeTech/java-pmc/raw/refs/heads/main/OpenJDK21U-jre_x64_windows_hotspot_21.0.4_7.zip"

set "JAVA_ZIP1=OpenJDK8U.zip"
set "JAVA_ZIP2=OpenJDK17U.zip"
set "JAVA_ZIP3=OpenJDK21U.zip"

:: Check if prism84 file exists
if exist "%PRISM_FILE%" (
    echo File 'prism84' found. Skipping download...
    goto start
) else (
    echo File 'prism84' not found. Proceeding with download...
)

:: Download the file
echo Downloading file...
bitsadmin /transfer "PrismLauncherDownload" "%DOWNLOAD_URL%" "%ZIP_FILE%"

:: Unzip the downloaded file using PowerShell
echo Unzipping contents...
PowerShell -Command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%PRISM_FOLDER%' -Force"

:: Create the marker file "prism84"
echo Creating marker file...
echo. > "%PRISM_FILE%"

copy /Y "%cd%/config.yml" "%PRISM_FOLDER%"
copy /Y "%cd%/accounts.yml" "%PRISM_FOLDER%"


:start
:: Check for javaV1 marker file
if exist "%JAVA_MARKER%" (
    echo Java environment already set up. Skipping to launch...
    goto launch
) else (
    echo Java environment not found. Proceeding with download...
)

:: Download the Java zip packages
echo Downloading Java JRE packages...
bitsadmin /transfer "JavaDownload1" "%JAVA_URL1%" "%JAVA_ZIP1%"
bitsadmin /transfer "JavaDownload2" "%JAVA_URL2%" "%JAVA_ZIP2%"
bitsadmin /transfer "JavaDownload3" "%JAVA_URL3%" "%JAVA_ZIP3%"

:: Extract the downloaded Java zip files using PowerShell
echo Extracting Java JRE packages...
PowerShell -Command "Expand-Archive -Path '%JAVA_ZIP1%' -DestinationPath '%DOCS_DIR%' -Force"
PowerShell -Command "Expand-Archive -Path '%JAVA_ZIP2%' -DestinationPath '%DOCS_DIR%' -Force"
PowerShell -Command "Expand-Archive -Path '%JAVA_ZIP3%' -DestinationPath '%DOCS_DIR%' -Force"

:: Create the marker file "javaV1"
echo Creating Java setup marker file...
echo. > "%JAVA_MARKER%"

:launch
echo Launching application...
:: Add any further launch steps here

pause
