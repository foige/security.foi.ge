@echo off
setlocal EnableDelayedExpansion

:: Set larger window size
mode con cols=120 lines=50

:: Check for admin privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo  Administrator privileges required.
    echo  Please run as administrator.
    echo.
    pause
    exit /b 1
)

:menu
:: Initialize variables
set "os_encrypted="
set "restart_pending="
set "has_insecure_encryption="
set "insecure_drives="

cls
echo.
echo Copyright (C) 2024 FOI Georgia https://security.foi.ge
echo =======================================================
echo.
echo FOI Security Tools - BitLocker Manager
echo.
echo =======================================
echo.

:: Get list of drives and check BitLocker status
set "index=0"
for /f "delims=" %%a in ('powershell -noprofile -command "$volumes = Get-Volume | Where-Object {($_.DriveType -eq 'Fixed' -or $_.DriveType -eq 'Removable') -and $_.DriveLetter}; foreach ($vol in $volumes) { $vol.DriveLetter + ':' }"') do (
    set /a "index+=1"
    set "drive[!index!]=%%a"

    :: Get default status and checks
    set "encrypt_status=Not Encrypted"
    set "is_encrypted="
    set "has_secure_encryption="
    set "encryption_method="
    set "is_fully_decrypted="
    set "is_encrypting="
    set "is_decrypting="
    set "current_drive=%%a"

    :: Check BitLocker status
    for /f "tokens=*" %%x in ('manage-bde -status !current_drive! ^| findstr /i "BitLocker Version Encryption Method Conversion Status"') do (
        set "line=%%x"
        
        :: Check BitLocker Version
        if not "!line:BitLocker Version=!"=="!line!" (
            if not "!line:None=!"=="!line!" (
                set "is_encrypted="
            ) else if not "!line:2.0=!"=="!line!" (
                set "is_encrypted=1"
            )
        )
        
        :: Check Encryption Method
        if not "!line:Encryption Method=!"=="!line!" (
            if not "!line:None=!"=="!line!" (
                set "is_encrypted="
            ) else (
                :: Extract encryption method and trim whitespace
                for /f "tokens=2 delims=:" %%m in ("!line!") do (
                    set "encryption_method=%%m"
                    set "encryption_method=!encryption_method: =!"
                )
                if "!encryption_method!"=="XTS-AES256" (
                    set "has_secure_encryption=1"
                ) else if not "!encryption_method!"=="" (
                    set "has_insecure_encryption=1"
                    set "insecure_drives=!insecure_drives!!current_drive! "
                )
            )
        )

        :: Check Conversion Status
        if not "!line:Fully Decrypted=!"=="!line!" (
            set "is_fully_decrypted=1"
            set "is_encrypted="
        ) else if not "!line:Fully Encrypted=!"=="!line!" (
            if /i "!current_drive!"=="%SystemDrive%" (
                set "os_encrypted=1"
            )
        ) else if not "!line:Encryption in Progress=!"=="!line!" (
            set "is_encrypting=1"
        ) else if not "!line:Decryption in Progress=!"=="!line!" (
            set "is_decrypting=1"
        )

        :: Check for pending restart
        if not "!line:Encryption will begin after the hardware test succeeds=!"=="!line!" (
            set "restart_pending=1"
        )
    )

    :: Determine final status
    if defined is_encrypted (
        if defined is_fully_decrypted (
            set "encrypt_status=NOT ENCRYPTED"
        ) else if not defined has_secure_encryption (
            set "encrypt_status=INSECURE (!encryption_method!)"
        ) else (
            set "encrypt_status=ENCRYPTED"
        )
    ) else (
        set "encrypt_status=NOT ENCRYPTED"
    )

    echo    !index!. Drive !current_drive! - !encrypt_status!
)

echo.
if defined has_insecure_encryption (
    echo  WARNING: The following drives are using insecure encryption: !insecure_drives!
    echo          Please disable BitLocker on these drives first and re-enable with XTS-AES256.
    echo.
) else if defined restart_pending (
    echo  NOTICE: Restart required to begin BitLocker encryption on %SystemDrive%
    echo          Please restart your computer to continue.
    echo.
) else if not defined os_encrypted (
    echo  WARNING: OS Drive %SystemDrive% is not encrypted. Please encrypt the drive %SystemDrive% first
    echo  before encrypting any data drives.
    echo.
)

echo  Available Actions:
echo  -----------------------------------------------
echo    1-9. Enter number of a drive to manage BitLocker
echo    R. Refresh status
echo    Q. Exit program
echo  -----------------------------------------------
echo.
set /p "choice=Selection: "

if /i "!choice!"=="Q" (
    echo.
    echo Exiting BitLocker Manager...
    goto :eof
)
if /i "!choice!"=="R" goto menu

:: Validate choice is a number and within range
set "valid=true"
for /f "delims=0123456789" %%i in ("%choice%") do set "valid=false"
if %choice% gtr %index% set "valid=false"
if %choice% leq 0 set "valid=false"

if "%valid%"=="false" (
    echo  Invalid selection.
    pause
    goto menu
)

:drive_menu
cls
set "selected_drive=!drive[%choice%]!"

:: Check drive encryption status and conversion state
set "is_encrypted="
set "is_encrypting="
set "is_decrypting="
for /f "tokens=*" %%x in ('manage-bde -status %selected_drive% ^| findstr /i "BitLocker Version Conversion Status"') do (
    set "line=%%x"
    if not "!line:None=!"=="!line!" (
        set "is_encrypted="
    ) else if not "!line:2.0=!"=="!line!" (
        set "is_encrypted=1"
    )
    if not "!line:Encryption in Progress=!"=="!line!" (
        set "is_encrypting=1"
    ) else if not "!line:Decryption in Progress=!"=="!line!" (
        set "is_decrypting=1"
    )
)

echo.
echo  Drive %selected_drive% Management
echo  ===============================================
echo.
manage-bde -status %selected_drive%
echo.
echo  -------------------------------------------------------
if defined is_encrypted (
    if defined is_encrypting (
        echo    BitLocker encryption in progress...
        echo.
        :: Monitor encryption progress with fvenotify
        start /b fvenotify.exe !selected_drive!
    ) else if defined is_decrypting (
        echo    BitLocker decryption in progress...
        echo.
        :: Monitor decryption progress with fvenotify
        start /b fvenotify.exe !selected_drive!
    ) else (
        echo    BitLocker is enabled
    )
) else (
    if not defined os_encrypted (
        if /i "%selected_drive%"=="%SystemDrive%" (
            echo    BitLocker is not enabled
        ) else (
            echo  ERROR: OS Drive %SystemDrive% must be encrypted before encrypting data drives.
            echo  Please encrypt the drive %SystemDrive% first.
        )
    ) else (
        echo    BitLocker is not enabled
    )
)
echo.
echo  Available Actions:
echo  -------------------------------------------------------
if defined is_encrypted (
    if defined is_encrypting (
        echo    1. Back to main menu
        echo    2. Refresh status
    ) else if defined is_decrypting (
        echo    1. Back to main menu
        echo    2. Refresh status
    ) else (
        echo    1. Disable BitLocker
        echo    2. Back to main menu
        echo    3. Refresh status
    )
) else (
    if /i "%selected_drive%"=="%SystemDrive%" (
        echo    1. Enable BitLocker
        echo    2. Back to main menu
        echo    3. Refresh status
    ) else if not defined os_encrypted (
        echo    1. Back to main menu
        echo    2. Refresh status
    ) else (
        echo    1. Enable BitLocker
        echo    2. Back to main menu
        echo    3. Refresh status
    )
)
echo  -------------------------------------------------------
echo.
set /p "action=Selection: "

:: Standardized action handling
if defined is_encrypted (
    if defined is_encrypting (
        if "!action!"=="1" goto menu
        if "!action!"=="2" goto drive_menu
    ) else if defined is_decrypting (
        if "!action!"=="1" goto menu
        if "!action!"=="2" goto drive_menu
    ) else (
        if "!action!"=="1" (
            echo.
            choice /c YN /M "Are you sure you want to disable BitLocker on drive !selected_drive!? "
            if !errorlevel! equ 1 goto disable_bitlocker
            goto drive_menu
        )
        if "!action!"=="2" goto menu
        if "!action!"=="3" goto drive_menu
    )
) else (
    if /i "!selected_drive!"=="%SystemDrive%" (
        if "!action!"=="1" goto enable_bitlocker
        if "!action!"=="2" goto menu
        if "!action!"=="3" goto drive_menu
    ) else if not defined os_encrypted (
        if "!action!"=="1" goto menu
        if "!action!"=="2" goto drive_menu
    ) else (
        if "!action!"=="1" goto enable_bitlocker
        if "!action!"=="2" goto menu
        if "!action!"=="3" goto drive_menu
    )
)

echo  Invalid option.
pause
goto drive_menu

:enable_bitlocker
cls
echo.
echo  Enabling BitLocker: Drive %selected_drive%
echo  ===============================================
echo.

echo BitLocker will now prompt you to enter a password to unlock the drive.

manage-bde -protectors -add %selected_drive% -Password
if %errorlevel% neq 0 goto enable_bitlocker_cleanup

:: Add auto-unlock for data drives
if /i not "%selected_drive%"=="%SystemDrive%" (
    echo Adding auto-unlock capability...
    manage-bde -autounlock -enable %selected_drive% >nul
    if %errorlevel% neq 0 (
        echo WARNING: Failed to enable auto-unlock. The drive will need to be unlocked manually.
    )
)

cls
echo.
echo  Enabling BitLocker: Drive %selected_drive%
echo  ===============================================
echo.

manage-bde -protectors -add %selected_drive% -RecoveryPassword
if %errorlevel% neq 0 goto enable_bitlocker_cleanup


:confirm_recovery_saved
echo.
echo WARNING WARNING WARNING WARNING WARNING: 
echo.
echo    Save Numerical Password ID and Recovery Password in a password manager!
echo    (key ID as 'username' and the recovery password itself as 'password')
echo.
echo    Have you saved the Numerical Password ID and Password in a password manager?
echo.
choice /c YN /M "Enter Y for Yes or N for No: "
if %errorlevel% equ 2 (
    echo.
    echo  Cancelling BitLocker enablement...
    goto enable_bitlocker_cleanup
)

:: Enable BitLocker with XTS-AES256 encryption
echo Enabling BitLocker with XTS-AES256 encryption. This may take some time. Do not interrupt!
manage-bde -on %selected_drive% -encryptionmethod xts_aes256
if %errorlevel% neq 0 goto enable_bitlocker_cleanup

echo.
echo  BitLocker will be enabled on drive %selected_drive%
echo.
timeout
goto drive_menu

:enable_bitlocker_cleanup
echo.
echo  ERROR: BitLocker enablement failed. Attempting to disable BitLocker...
manage-bde -off %selected_drive%
if %errorlevel% neq 0 (
    echo  Failed to disable BitLocker after failed enablement. Manual intervention may be required.
) else (
    echo  BitLocker disabled due to failed enablement.
)
echo.
pause
goto drive_menu

:disable_bitlocker
cls
echo.
echo  Disabling BitLocker: Drive %selected_drive%
echo  ===============================================
echo.

echo Disabling BitLocker. This may take a very long time. Do not interrupt!

manage-bde -off %selected_drive%
if %errorlevel% neq 0 goto disable_bitlocker_failed

echo.
echo  BitLocker will be disabled on drive %selected_drive%
pause
goto drive_menu

:disable_bitlocker_failed
echo.
echo  ERROR: Disabling BitLocker failed. Check the event logs for more information.
echo.
pause
goto drive_menu