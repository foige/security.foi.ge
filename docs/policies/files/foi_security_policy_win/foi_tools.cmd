@echo off
setlocal EnableDelayedExpansion

for /f "delims=" %%i in ('echo prompt $E ^| cmd') do set "ESC=%%i"
title FOI Tools

:: Set the script directory relative to this batch file's location
set "ScriptDir=%~dp0.."

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

:MainMenu
echo       FOI Tools
echo     __________________________________________________
echo.
echo       [1] Install FOI Security Policy
echo       [2] Enforce PIN Login (Disable Passwords)
echo       [3] Enforce Fingerprint Timeout
echo       [4] [EXPERT] Backup GPO
echo       [5] Exit
echo     __________________________________________________
echo.
echo       Select an option:
echo.
choice /C:12345 /N /M "Enter your choice:"

:: Choice handling
if errorlevel 5 goto :eof
if errorlevel 4 goto BackupGPO
if errorlevel 3 goto EnforceFingerprintTimeout
if errorlevel 2 goto EnforcePINLogin
if errorlevel 1 goto InstallGPO

:EnforcePINLogin
cls
echo Disabling password providers...

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{60b78e88-ead8-445c-9cfd-0b87f74ea6cd}" /v "Disabled" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{60b78e88-ead8-445c-9cfd-0b87f74ea6cd}\LogonPasswordReset" /v "Disabled" /t REG_DWORD /d 1 /f

echo Passwords have been disabled.
pause
goto MainMenu

:InstallGPO
cls
echo Installing FOI Security Policy...
echo Copying definitions from: "%ScriptDir%\PolicyDefinitions" to "%SystemRoot%\PolicyDefinitions\"
xcopy /S /Y "%ScriptDir%\PolicyDefinitions" "%SystemRoot%\PolicyDefinitions\"
cd "%ScriptDir%\LGPO"
for /D %%D in ("%ScriptDir%\LGPO\policy\*") do (
    "%ScriptDir%\LGPO\LGPO.exe" /g "%%D"
    goto ProcessComplete
)
:ProcessComplete
echo Updating group policies...
gpupdate /force
echo Group Policy installation complete.
pause
goto MainMenu

:EnforceFingerprintTimeout
cls
echo Enforcing fingerprint timeout...
echo Placeholder for implementing fingerprint timeout policy.
pause
goto MainMenu

:BackupGPO
cls
echo Performing Backup...
if exist "%ScriptDir%\LGPO\backup" (
    rmdir /s /q "%ScriptDir%\LGPO\backup"
    echo Directory LGPO\backup removed
)
mkdir "%ScriptDir%\LGPO\backup"
echo Starting LGPO backup...
"%ScriptDir%\LGPO\LGPO.exe" /b "%ScriptDir%\LGPO\backup"
echo Backup completed.
:: Parse the backup data
set "BackupPath=%ScriptDir%\LGPO\backup"
for /r "%BackupPath%" %%f in (*.pol) do (
    for %%d in ("%%~pf.") do set "DirName=%%~nxd"
    set "OutputFile=%ScriptDir%\LGPO\backup\%DirName%.txt"
    "%ScriptDir%\LGPO\LGPO.exe" /parse /m "%%f" > "%OutputFile%"
    echo Parsed data saved to: %OutputFile%
)
echo All backup data has been parsed and saved.
pause
goto MainMenu