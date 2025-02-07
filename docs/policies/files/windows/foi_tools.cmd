@echo off
setlocal EnableDelayedExpansion

:: Define Escape character
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
echo       [4] BitLocker-is Martva
echo       [5] [EXPERT] PIN Kodit Shesvlis Gauqmeba
echo       [6] [EXPERT] Titis Anabechdis Drois Shezgudvis Gauqmeba
echo       [7] [EXPERT] GPO-s Shenakhva
echo       [8] [EXPERT] GPO-s Aghdgena
echo       [9] Gamosvla
echo     __________________________________________________
echo.
echo       Airchiet Operacia:
echo.
set /p choice="Sheiyvanet tqveni archevani: "

:: Choice handling
if "%choice%"=="9" goto :EOF
if "%choice%"=="8" goto RestoreGPO
if "%choice%"=="7" goto SaveGPO
if "%choice%"=="6" goto DisableFingerprintTimeout
if "%choice%"=="5" goto DisablePINLogin
if "%choice%"=="4" goto ManageBitLocker
if "%choice%"=="3" goto EnforceFingerprintTimeout
if "%choice%"=="2" goto EnforcePINLogin
if "%choice%"=="1" goto InstallGPO

:: If no valid choice was made, return to MainMenu
echo [ERROR] Araswori archevani
pause
goto MainMenu

:CheckTPM
cls
echo TPM-is shemowmeba...
powershell -ExecutionPolicy Bypass -Command "$tpm = Get-Tpm; exit ([int]($tpm.TpmPresent -and $tpm.TpmEnabled))"
set /a TPM_AVAILABLE=%ERRORLEVEL%
if "%TPM_AVAILABLE%"=="0" (
    echo [ERROR] TPM ar aris xelmisawvdomi an gaaktiurebuli!
    echo [ERROR] Aucilebelia TPM 2.0-is arseboba da gaaqtiureba.
    echo [ERROR] Gaaaqtiuret TPM BIOS-is parametrebshi da scadet xelaxla.
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
    echo [ERROR] PIN kodis dasayeneblad: Settings ^> Accounts ^> Sign-in options ^> PIN ^(Windows Hello^) ^> Set Up
    pause
    exit /b 1
)
exit /b 0

:ManageBitLocker
cls
echo BitLocker-is martvis instrumentis gashveba...
start "FOI - BitLocker Management" cmd /c ""%ScriptDir%\bl_tools.cmd""
goto MainMenu

:EnforcePINLogin
cls
call :CheckTPM
if errorlevel 1 goto MainMenu

call :CheckPIN
if errorlevel 1 goto MainMenu

echo Mimdinareobs PIN kodit shesvlis idzulebis aqtivacia...
powershell -ExecutionPolicy Bypass -Command "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{60b78e88-ead8-445c-9cfd-0b87f74ea6cd}' -Name 'Disabled' -Value '1'"
if errorlevel 1 (
    echo [ERROR] PIN kodit shesvlis idzulebis gaaqtiurebisas moxda shecdoma
    pause
    goto MainMenu
)

powershell -ExecutionPolicy Bypass -Command "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{60b78e88-ead8-445c-9cfd-0b87f74ea6cd}\LogonPasswordReset' -Name 'Disabled' -Value '1'"
if errorlevel 1 (
    echo [ERROR] PIN kodit shesvlis idzulebis gaaqtiurebisas moxda shecdoma
    pause
    goto MainMenu
)

echo [OK] PIN kodit shesvlis idzuleba gaaqtiurebulia.
pause
goto MainMenu

:DisablePINLogin
cls
echo Mimdinareobs PIN kodit shesvlis idzulebis gauqmeba...
powershell -ExecutionPolicy Bypass -Command "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{60b78e88-ead8-445c-9cfd-0b87f74ea6cd}' -Name 'Disabled' -Value '0'"
if errorlevel 1 (
    echo [ERROR] PIN kodit shesvlis idzulebis gauqmebisas moxda shecdoma
    pause
    goto MainMenu
)

powershell -ExecutionPolicy Bypass -Command "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{60b78e88-ead8-445c-9cfd-0b87f74ea6cd}\LogonPasswordReset' -Name 'Disabled' -Value '0'"
if errorlevel 1 (
    echo [ERROR] PIN kodit shesvlis idzulebis gauqmebisas moxda shecdoma
    pause
    goto MainMenu
)

echo [OK] PIN kodit shesvlis idzuleba gauqmebulia.
pause
goto MainMenu

:EnforceFingerprintTimeout
cls
echo Mimdinareobs titis anabechdis drois shezgudvis idzuleba...
schtasks /create /tn "FOIPinEnforcementEnable" /xml "%ScriptDir%\tasks\FOIPinEnforcementEnable.xml" /f
if errorlevel 1 (
    echo [ERROR] Titis anabechdis drois shezgudvis gaaqtiurebisas moxda shecdoma
    pause
    goto MainMenu
)

schtasks /create /tn "FOIPinEnforcementDisable" /xml "%ScriptDir%\tasks\FOIPinEnforcementDisable.xml" /f
if errorlevel 1 (
    echo [ERROR] Titis anabechdis drois shezgudvis gaaqtiurebisas moxda shecdoma
    schtasks /delete /tn "FOIPinEnforcementEnable" /f >nul 2>&1
    pause
    goto MainMenu
)

echo [OK] Titis anabechdis drois shezgudva gaaqtiurebulia.
pause
goto MainMenu

:DisableFingerprintTimeout
cls
echo Mimdinareobs titis anabechdis drois shezgudvis gauqmeba...
schtasks /delete /tn "FOIPinEnforcementEnable" /f
if errorlevel 1 (
    echo [ERROR] Titis anabechdis drois shezgudvis gauqmebisas moxda shecdoma
    pause
    goto MainMenu
)

schtasks /delete /tn "FOIPinEnforcementDisable" /f
if errorlevel 1 (
    echo [ERROR] Titis anabechdis drois shezgudvis gauqmebisas moxda shecdoma
    pause
    goto MainMenu
)

echo [OK] Titis anabechdis drois shezgudva gauqmebulia.
pause
goto MainMenu

:ResetGPO
echo Mimdinareobs GPO-s sawyis parametrebze dabruneba...
rmdir /s /q "%SystemRoot%\System32\GroupPolicy" 2>nul
gpupdate /force
if errorlevel 1 (
    echo [ERROR] GPO-s gadatvirtvisas moxda shecdoma
    exit /b 1
)
exit /b 0

:RestoreGPO
cls
echo Sarezervo aslebis sia...

if not exist "%BackupBaseDir%" (
    echo [ERROR] Sarezervo aslebis saqaghalde ar arsebobs: %BackupBaseDir%
    pause
    goto MainMenu
)

:: Create a temporary file to store backup directories
set "tempFile=%temp%\backups.txt"
dir /b /ad /o-d "%BackupBaseDir%\backup_*" > "%tempFile%" 2>nul

:: Count lines in temp file
set "count=0"
for /f %%a in (%tempFile%) do set /a "count+=1"

if %count% equ 0 (
    echo [ERROR] Sarezervo aslebi ver moidzebna
    del "%tempFile%" 2>nul
    pause
    goto MainMenu
)

echo.
echo Bolo 10 sarezervo asli:
echo ------------------------

:: Display last 10 backups with numbers
set "displayCount=0"
for /f "delims=" %%a in (%tempFile%) do (
    set /a "displayCount+=1"
    if !displayCount! leq 10 (
        set "backup=%%a"
        :: Extract date and time from backup name (format: backup_YYYYMMDD_HHMMSS)
        set "datetime=!backup:~7!"
        :: Format date for display
        set "year=!datetime:~0,4!"
        set "month=!datetime:~4,2!"
        set "day=!datetime:~6,2!"
        set "hour=!datetime:~9,2!"
        set "minute=!datetime:~11,2!"
        set "second=!datetime:~13,2!"
        echo [!displayCount!] !year!-!month!-!day! !hour!:!minute!:!second!
        set "backup!displayCount!=%%a"
    )
)

echo.
set /p choice="Airchiet sarezervo asli (1-%displayCount%): "

:: Validate choice
set "choiceNum=%choice%"
set /a "choiceNum=%choiceNum%" 2>nul
if "%choiceNum%"=="" goto InvalidChoice
if %choiceNum% lss 1 goto InvalidChoice
if %choiceNum% gtr %displayCount% goto InvalidChoice

:: Get selected backup path
call set "selectedBackup=%%backup%choice%%%"
set "backupPath=%BackupBaseDir%\%selectedBackup%"

echo Mimdinareobs sarezervo aslis aghdgena: %selectedBackup%...

:: Reset GPO and restore from backup
call :ResetGPO
if errorlevel 1 (
    del "%tempFile%" 2>nul
    pause
    goto MainMenu
)

cd "%ScriptDir%\LGPO"
.\LGPO.exe /g "%backupPath%"
if errorlevel 1 (
    echo [ERROR] Sarezervo aslis aghdgenisas moxda shecdoma
    del "%tempFile%" 2>nul
    pause
    goto MainMenu
)

gpupdate /force
if errorlevel 1 (
    echo [ERROR] GPO-s ganakhlebisas moxda shecdoma
    del "%tempFile%" 2>nul
    pause
    goto MainMenu
)

echo [OK] Sarezervo aslis aghdgena dasrulda
del "%tempFile%" 2>nul
pause
goto MainMenu

:InvalidChoice
echo [ERROR] Araswori archevani
del "%tempFile%" 2>nul
pause
goto MainMenu

:InstallGPO
cls
set "calledFromInstall=1"
call :SaveGPO
if errorlevel 1 goto MainMenu
set "calledFromInstall=0"

echo Mimdinareobs FOI usafrtxoebis politikis dayeneba...
call :ResetGPO
if errorlevel 1 goto MainMenu

echo Parametrebis kopireba: "%ScriptDir%\PolicyDefinitions" to "%SystemRoot%\PolicyDefinitions\"
xcopy /S /Y "%ScriptDir%\PolicyDefinitions" "%SystemRoot%\PolicyDefinitions\"
if errorlevel 1 (
    echo [ERROR] Parametrebis kopirebisas moxda shecdoma
    pause
    goto MainMenu
)

cd "%ScriptDir%\LGPO"
for /D %%D in ("%ScriptDir%\LGPO\policy\*") do (
    "%ScriptDir%\LGPO\LGPO.exe" /g "%%D"
    if errorlevel 1 (
        echo [ERROR] LGPO-s dayenebisas moxda shecdoma
        pause
        goto MainMenu
    )
    goto InstallGPOComplete
)

:InstallGPOComplete
echo Mimdinareobs FOI usafrtxoebis politikis dayeneba...
gpupdate /force
if errorlevel 1 (
    echo [ERROR] GPO-s ganakhlebisas moxda shecdoma
    pause
    goto MainMenu
)

echo [OK] FOI usafrtxoebis politikis dayeneba dasrulda.
pause
goto MainMenu

:SaveGPO
cls
echo Mimdinareobs sarezervo aslis sheqmna...

:: Get the current date and time to create a unique backup directory
for /f "delims=" %%I in ('powershell -Command "Get-Date -Format yyyyMMdd_HHmmss"') do set datetime=%%I
set "backupDir=%BackupBaseDir%\backup_%datetime%"

if not exist "%BackupBaseDir%\" mkdir "%BackupBaseDir%"
if errorlevel 1 (
    echo [ERROR] Sarezervo aslebis saqaghaldis sheqmnisas moxda shecdoma
    pause
    goto MainMenu
)

mkdir "%backupDir%"
if errorlevel 1 (
    echo [ERROR] Sarezervo aslis saqaghaldis sheqmnisas moxda shecdoma
    pause
    goto MainMenu
)

echo Iwyeba LGPO-is sarezervo aslis sheqmna...
cd "%ScriptDir%\LGPO\"
.\LGPO.exe /b "%backupDir%"
if errorlevel 1 (
    echo [ERROR] LGPO-s sarezervo aslis sheqmnisas moxda shecdoma
    pause
    goto MainMenu
)
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
    if errorlevel 1 (
        echo [ERROR] Failis damushavebisas moxda shecdoma: %%~nxf
        pause
        goto MainMenu
    )
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
exit /b %ERRORLEVEL%
