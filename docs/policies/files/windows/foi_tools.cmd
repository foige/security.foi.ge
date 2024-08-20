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
set "line1= _   _  ___       _____ ___       ____  _   _ ____ ____ ___    _    _   _      _        ___        __"
set "line2=| \ | |/ _ \     |_   _/ _ \     |  _ \| | | / ___/ ___|_ _|  / \  | \ | |    | |      / \ \      / /"
set "line3=|  \| | | | |      | || | | |    | |_) | | | \___ \___ \| |  / _ \ |  \| |    | |     / _ \ \ /\ / / "
set "line4=| |\  | |_| |      | || |_| |    |  _ <| |_| |___) |__) | | / ___ \| |\  |    | |___ / ___ \ V  V /  "
set "line5=|_| \_|\___/       |_| \___/     |_| \_\\___/|____/____/___/_/   \_\_| \_|    |_____/_/   \_\_/\_/   "

echo !line1!
echo !line2!
echo !line3!
echo !line4!
echo !line5!
echo.
echo __________________________________________________
echo Copyright (C) 2024 FOI Georgia https://security.foi.ge
echo.
echo       FOI Tools
echo     __________________________________________________
echo.
echo       [1] Install FOI Security Policy
echo       [2] Enforce PIN Login (Disable Passwords)
echo       [3] Enforce Fingerprint Timeout
echo       [4] [EXPERT] Disable PIN Login Enforcement
echo       [5] [EXPERT] Disable Multi-Factor Login
echo       [6] [EXPERT] Save GPO
echo       [7] Exit
echo     __________________________________________________
echo.
echo       Select an option:
echo.
set /p choice="Enter your choice: "

:: Choice handling
if "%choice%"=="7" goto :eof
if "%choice%"=="6" goto SaveGPO
if "%choice%"=="5" goto DisableFingerprintTimeout
if "%choice%"=="4" goto DisablePINLogin
if "%choice%"=="3" goto EnforceFingerprintTimeout
if "%choice%"=="2" goto EnforcePINLogin
if "%choice%"=="1" goto InstallGPO

:EnforcePINLogin
cls
echo Enforcing PIN login...
powershell -ExecutionPolicy Bypass -Command "Set-ItemProperty -Path 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{60b78e88-ead8-445c-9cfd-0b87f74ea6cd}' -Name 'Disabled' -Value '1'"
powershell -ExecutionPolicy Bypass -Command "Set-ItemProperty -Path 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{60b78e88-ead8-445c-9cfd-0b87f74ea6cd}\LogonPasswordReset' -Name 'Disabled' -Value '1'"
echo PIN login has been enforced.
pause
goto MainMenu

:DisablePINLogin
cls
echo Disabling PIN login enforcement...
powershell -ExecutionPolicy Bypass -Command "Set-ItemProperty -Path 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{60b78e88-ead8-445c-9cfd-0b87f74ea6cd}' -Name 'Disabled' -Value '0'"
powershell -ExecutionPolicy Bypass -Command "Set-ItemProperty -Path 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{60b78e88-ead8-445c-9cfd-0b87f74ea6cd}\LogonPasswordReset' -Name 'Disabled' -Value '0'"
echo PIN login enforcement has been disabled.
pause
goto MainMenu

:EnforceFingerprintTimeout
cls
echo Enforcing fingerprint timeout...
:: Create timeout tasks
schtasks /create /tn "FOIPinEnforcementEnable" /xml "%ScriptDir%\tasks\FOIPinEnforcementEnable.xml" /f
schtasks /create /tn "FOIPinEnforcementDisable" /xml "%ScriptDir%\tasks\FOIPinEnforcementDisable.xml" /f
pause
goto MainMenu

:DisableFingerprintTimeout
cls
echo Disabling fingerprint timeout...
schtasks /delete /tn "FOIPinEnforcementEnable" /f
schtasks /delete /tn "FOIPinEnforcementDisable" /f
pause
goto MainMenu

:InstallGPO
cls
set "calledFromInstall=1"
call :SaveGPO
set "calledFromInstall=0"
echo Installing FOI Security Policy...
echo Copying definitions from: "%ScriptDir%\PolicyDefinitions" to "%SystemRoot%\PolicyDefinitions\"
xcopy /S /Y "%ScriptDir%\PolicyDefinitions" "%SystemRoot%\PolicyDefinitions\"
cd "%ScriptDir%\LGPO"
for /D %%D in ("%ScriptDir%\LGPO\policy\*") do (
    "%ScriptDir%\LGPO\LGPO.exe" /g "%%D"
    goto InstallGPOComplete
)
:InstallGPOComplete
echo Updating group policies...
gpupdate /force
echo Group Policy installation complete.
pause
goto MainMenu

:SaveGPO
cls
echo Performing Backup...

:: Get the current date and time to create a unique backup directory
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set backupDir=%BackupBaseDir%\backup_%datetime:~0,8%_%datetime:~8,6%

if not exist "%BackupBaseDir%\" mkdir "%BackupBaseDir%"
mkdir "%backupDir%"

echo Starting LGPO backup...
cd "%ScriptDir%\LGPO\"
.\LGPO.exe /b "%backupDir%"
echo Backup completed.

echo Parsing backup data...
set "BackupPath=%backupDir%"

:: Process each .pol file and save the output to a txt file named after the directory
for /r "%BackupPath%" %%f in (*.pol) do (
    echo Processing file: %%~nxf
    :: Extract the directory name
    for %%d in ("%%~pf.") do set "DirName=%%~nxd"
    set "OutputFile=%backupDir%\!DirName!.txt"
    .\LGPO.exe /parse /m "%%f" > "!OutputFile!"
    echo Parsed data saved to: !OutputFile!
)

echo All backup data has been parsed and saved.
echo.
echo.
echo.
if "%calledFromInstall%"=="0" (
    pause
    goto MainMenu
)
exit /b