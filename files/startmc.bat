@echo off
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

:checkprisminstalled
if exist "%PRISM_FILE%" (
    echo File 'prism84' found. Skipping download...
    goto java
) else (
    echo File 'prism84' not found. Proceeding with download...
)

:downloadprismzip
echo Downloading file...
bitsadmin /transfer "PrismLauncherDownload" "%DOWNLOAD_URL%" "%ZIP_FILE%"

:unzipprismzip
echo Unzipping contents...
PowerShell -Command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%PRISM_FOLDER%' -Force"

:createmarker
echo Creating marker file...
echo. > "%PRISM_FILE%"

:copyconfig
copy /Y "%cd%/config.yml" "%PRISM_FOLDER%"
copy /Y "%cd%/accounts.yml" "%PRISM_FOLDER%"


:java
:: Check for javaV1 marker file
if exist "%JAVA_MARKER%" (
    echo Java environment already set up. Skipping to launch...
    goto launch
) else (
    echo Java environment not found. Proceeding with download...
)

:javadl
echo Downloading Java JRE packages...
bitsadmin /transfer "JavaDownload1" "%JAVA_URL1%" "%JAVA_ZIP1%"
bitsadmin /transfer "JavaDownload2" "%JAVA_URL2%" "%JAVA_ZIP2%"
bitsadmin /transfer "JavaDownload3" "%JAVA_URL3%" "%JAVA_ZIP3%"

:javaextract
echo Extracting Java JRE packages...
PowerShell -Command "Expand-Archive -Path '%JAVA_ZIP1%' -DestinationPath '%DOCS_DIR%' -Force"
PowerShell -Command "Expand-Archive -Path '%JAVA_ZIP2%' -DestinationPath '%DOCS_DIR%' -Force"
PowerShell -Command "Expand-Archive -Path '%JAVA_ZIP3%' -DestinationPath '%DOCS_DIR%' -Force"

:javarename
ren "C:\Users\Public\Documents\jdk8u422-b05-jre" "java8"
ren "C:\Users\Public\Documents\jdk-17.0.12+7-jre" "java17"
ren "C:\Users\Public\Documents\jdk-21.0.4+7-jre" "java21"

:javamarker
echo Creating Java setup marker file...
echo. > "%JAVA_MARKER%"

:start
launch %cd%/prism prismlauncher.exe
:: Add any further launch steps here

pause
