@echo off
setlocal EnableDelayedExpansion

for /f "delims=" %%i in ('echo prompt $E ^| cmd') do set "ESC=%%i"
title FOI Tools

:: Set the script directory relative to this batch file's location
set "ScriptDir=%~dp0"
if "%ScriptDir:~-1%"=="\" set "ScriptDir=%ScriptDir:~0,-1%"
set "BackupBaseDir=%UserProfile%\Backups\LGPO"
set "calledFromInstall=0"

:MainMenu
cls

echo.
echo __________________________________________________
echo Copyright (C) 2024 FOI Georgia https://security.foi.ge
echo.
echo       FOI Security Tools
echo     __________________________________________________
echo.
echo       [1] FOI Usafrtxoebis Politikis Dayeneba
echo       [2] PIN Kodit Shesvlis Idzuleba
echo       [3] Titis Anabechdis Drois Shezgudvis Gaaqtiureba
echo       [4] [EXPERT] PIN Kodit Shesvlis Gauqmeba
echo       [5] [EXPERT] Titis Anabechdis Drois Shezgudvis Gauqmeba
echo       [6] [EXPERT] GPO-s Shenakhva
echo       [7] Gamosvla
echo     __________________________________________________
echo.
echo       Airchiet Operacia:
echo.
set /p choice="Sheiyvanet tqveni archevani: "

:: Choice handling
if "%choice%"=="7" goto :eof
if "%choice%"=="6" goto SaveGPO
if "%choice%"=="5" goto DisableFingerprintTimeout
if "%choice%"=="4" goto DisablePINLogin
if "%choice%"=="3" goto EnforceFingerprintTimeout
if "%choice%"=="2" goto EnforcePINLogin
if "%choice%"=="1" goto InstallGPO


:CheckTPM
cls
echo TPM-is shemowmeba...
powershell -ExecutionPolicy Bypass -Command "$tpm = Get-Tpm; exit ([int]($tpm.TpmPresent -and $tpm.TpmEnabled))"
set /a TPM_AVAILABLE=%ERRORLEVEL%
if "%TPM_AVAILABLE%"=="0" (
    echo TPM ar aris xelmisawvdomi an gaaktiurebuli!
    echo Aucilebelia TPM 2.0-is arseboba da gaaqtiureba.
    echo Gaaaqtiuret TPM BIOS-is parametrebshi da scadet xelaxla.
    pause
    exit /b 1
)
exit /b 0

:: PIN Check Function
:CheckPIN
cls
echo PIN kodis shemowmeba...
powershell -ExecutionPolicy Bypass -Command "$path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{D6886603-9D2F-4EB2-B667-1971041FA96B}'; $value = (Get-ChildItem $path | Get-ItemProperty).LogonCredsAvailable; exit ([int]([string]$value -eq '1'))"
set /a PIN_SETUP=%ERRORLEVEL%
if "%PIN_SETUP%"=="0" (
    echo [ERROR] Windows PIN kodi ar aris dayenebuli.
    echo [ERROR] Daayenet PIN kodi Windows-is parametrebshi.
    echo [ERROR] PIN kodis dasayeneblad: Settings ^> Accounts ^> Sign-in options ^> PIN ^> Add
    pause
    exit /b 1
)
exit /b 0

:EnforcePINLogin
cls
call :CheckTPM
if errorlevel 1 goto MainMenu

call :CheckPIN
if errorlevel 1 goto MainMenu

echo Mimdinareobs PIN kodit shesvlis idzulebis aqtivacia...
powershell -ExecutionPolicy Bypass -Command "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{60b78e88-ead8-445c-9cfd-0b87f74ea6cd}' -Name 'Disabled' -Value '1'"
powershell -ExecutionPolicy Bypass -Command "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{60b78e88-ead8-445c-9cfd-0b87f74ea6cd}\LogonPasswordReset' -Name 'Disabled' -Value '1'"
echo [OK] PIN kodit shesvlis idzuleba gaaqtiurebulia.
pause
goto MainMenu

:DisablePINLogin
cls
echo Mimdinareobs PIN kodit shesvlis idzulebis gauqmeba...
powershell -ExecutionPolicy Bypass -Command "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{60b78e88-ead8-445c-9cfd-0b87f74ea6cd}' -Name 'Disabled' -Value '0'"
powershell -ExecutionPolicy Bypass -Command "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{60b78e88-ead8-445c-9cfd-0b87f74ea6cd}\LogonPasswordReset' -Name 'Disabled' -Value '0'"
echo [OK] PIN kodit shesvlis idzuleba gauqmebulia.
pause
goto MainMenu

:EnforceFingerprintTimeout
cls
echo Mimdinareobs titis anabechdis drois shezgudvis idzuleba...
schtasks /create /tn "FOIPinEnforcementEnable" /xml "%ScriptDir%\tasks\FOIPinEnforcementEnable.xml" /f
schtasks /create /tn "FOIPinEnforcementDisable" /xml "%ScriptDir%\tasks\FOIPinEnforcementDisable.xml" /f
pause
goto MainMenu

:DisableFingerprintTimeout
cls
echo Mimdinareobs titis anabechdis drois shegudvis gauqmeba...
schtasks /delete /tn "FOIPinEnforcementEnable" /f
schtasks /delete /tn "FOIPinEnforcementDisable" /f
pause
goto MainMenu

:InstallGPO
cls
set "calledFromInstall=1"
call :SaveGPO
set "calledFromInstall=0"
echo Mimdinareobs FOI usafrtxoebis politikis dayeneba...
echo Parametrebis kopireba: "%ScriptDir%\PolicyDefinitions" to "%SystemRoot%\PolicyDefinitions\"
xcopy /S /Y "%ScriptDir%\PolicyDefinitions" "%SystemRoot%\PolicyDefinitions\"
cd "%ScriptDir%\LGPO"
for /D %%D in ("%ScriptDir%\LGPO\policy\*") do (
    "%ScriptDir%\LGPO\LGPO.exe" /g "%%D"
    goto InstallGPOComplete
)
:InstallGPOComplete
echo Mimdinareobs FOI usafrtxoebis politikis dayeneba...
gpupdate /force
echo [OK] FOI usafrtxoebis politikis dayeneba dasrulda.
pause
goto MainMenu

:SaveGPO
cls
echo Mimdinareobs sarezervo aslis sheqmna...

:: Get the current date and time to create a unique backup directory
for /f "delims=" %%I in ('powershell -Command "Get-Date -Format yyyyMMdd_HHmmss"') do set datetime=%%I
set backupDir=%BackupBaseDir%\backup_%datetime%

if not exist "%BackupBaseDir%\" mkdir "%BackupBaseDir%"
mkdir "%backupDir%"

echo Iwyeba LGPO-is sarezervo aslis sheqmna...
cd "%ScriptDir%\LGPO\"
.\LGPO.exe /b "%backupDir%"
echo Sarezervo aslis sheqmna dasrulda.

echo Mimdinareobs sarezervo monacemebis damushaveba...
set "BackupPath=%backupDir%"

:: Process each .pol file and save the output to a txt file named after the directory
for /r "%BackupPath%" %%f in (*.pol) do (
    echo Mushavdeba faili: %%~nxf
    :: Extract the directory name
    for %%d in ("%%~pf.") do set "DirName=%%~nxd"
    set "OutputFile=%backupDir%\!DirName!.txt"
    .\LGPO.exe /parse /m "%%f" > "!OutputFile!"
    echo Damushavebuli monacemebi shenakhulia: !OutputFile!
)

echo [OK] Sarezervo aslebis sheqmna dasrulda.
echo.
echo.
echo.
if "%calledFromInstall%"=="0" (
    pause
    goto MainMenu
)
exit /b