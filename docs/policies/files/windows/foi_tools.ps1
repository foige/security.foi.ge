﻿# Copyright (C) 2024 FOI Georgia https://security.foi.ge

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BackupBaseDir = Join-Path $env:USERPROFILE "Backups\LGPO"
$Global:calledFromInstall = $false

$normalText = "$([char]27)[0m"
$largeText = "$([char]27)[1m" 

# Set background color to black
[Console]::BackgroundColor = 'Black'

function Write-Success {
    param([string]$Message)
    Write-Host "`n`n`n$largeText[✓] $Message$normalText" -ForegroundColor Green
}

function Write-Error {
    param([string]$Message)
    Write-Host "$largeText[✗] $Message$normalText" -ForegroundColor Red
}

function Write-Info {
    param([string]$Message)
    Write-Host "$largeText$Message$normalText" -ForegroundColor Blue
}

function Return-ToMenu {
    Write-Host -NoNewline "$largeText"
    Write-Host "`nDaachiret Enter-s gasagrdzeleblad..." -NoNewline -ForegroundColor Yellow
    $null = Read-Host
    Write-Host "$normalText"
    [Console]::BackgroundColor = 'Black'
    Clear-Host
    Show-Menu
    Get-NextChoice
}

function Check-TPM {
    Clear-Host
    Write-Info "TPM-is shemowmeba..."
    $tpm = Get-Tpm
    if (-not ($tpm.TpmPresent -and $tpm.TpmEnabled)) {
        Write-Error "TPM ar aris xelmisawvdomi an gaaktiurebuli!"
        Write-Error "Aucilebelia TPM 2.0-is arseboba da gaaktiureba."
        Write-Error "Gaaaktiuret TPM BIOS-is parametrebshi da scadet xelaxla."
        Return-ToMenu
    }
    return $true
}

function Check-PIN {
    Clear-Host
    Write-Info "PIN kodis shemowmeba..."
    $path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{D6886603-9D2F-4EB2-B667-1971041FA96B}'
    $value = (Get-ChildItem $path | Get-ItemProperty).LogonCredsAvailable
    if ([string]$value -ne '1') {
        Write-Error "Windows PIN kodi ar aris dayenebuli."
        Write-Error "Daayenet PIN kodi Windows-is parametrebshi."
        Write-Error "PIN kodis dasayeneblad: Settings > Accounts > Sign-in options > PIN > Add"
        Return-ToMenu
    }
    return $true
}

function Enforce-PINLogin {
    Clear-Host
    Check-TPM
    Check-PIN

    Write-Info "Mimdinareobs PIN kodit shesvlis idzulebis aktivacia..."
    try {
        Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{60b78e88-ead8-445c-9cfd-0b87f74ea6cd}' -Name 'Disabled' -Value '1'
        Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{60b78e88-ead8-445c-9cfd-0b87f74ea6cd}\LogonPasswordReset' -Name 'Disabled' -Value '1'
        Write-Success "PIN kodit shesvlis idzuleba gaaktiurebulia."
    }
    catch {
        Write-Error "PIN kodit shesvlis idzulebis gaaktiurebisas moxda shecdoma: $_"
        Return-ToMenu
    }
    Return-ToMenu
}

function Disable-PINLogin {
    Clear-Host
    Write-Info "Mimdinareobs PIN kodit shesvlis idzulebis gaukmeba..."
    try {
        Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{60b78e88-ead8-445c-9cfd-0b87f74ea6cd}' -Name 'Disabled' -Value '0'
        Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{60b78e88-ead8-445c-9cfd-0b87f74ea6cd}\LogonPasswordReset' -Name 'Disabled' -Value '0'
        Write-Success "PIN kodit shesvlis idzuleba gaukmebulia."
    }
    catch {
        Write-Error "PIN kodit shesvlis idzulebis gaukmebisas moxda shecdoma: $_"
        Return-ToMenu
    }
    Return-ToMenu
}

function Enforce-FingerprintTimeout {
    Clear-Host
    Write-Info "mimdinareobs titis anabechdis drois shezgudvis idzuleba..."
    try {
        $enablePath = Join-Path $ScriptDir "tasks\FOIPinEnforcementEnable.xml"
        $disablePath = Join-Path $ScriptDir "tasks\FOIPinEnforcementDisable.xml"
        
        Register-ScheduledTask -TaskName "FOIPinEnforcementEnable" -Xml (Get-Content $enablePath | Out-String) -Force
        Register-ScheduledTask -TaskName "FOIPinEnforcementDisable" -Xml (Get-Content $disablePath | Out-String) -Force
        Write-Success "titis anabechdis drois shezgudva gaaktiurebulia."
    }
    catch {
        Write-Error "titis anabechdis drois shezgudvis gaaktiurebisas moxda shecdoma: $_"
        Return-ToMenu
    }
    Return-ToMenu
}

function Disable-FingerprintTimeout {
    Clear-Host
    Write-Info "mimdinareobs titis anabechdis drois shezgudvis gaukmeba..."
    try {
        Unregister-ScheduledTask -TaskName "FOIPinEnforcementEnable" -Confirm:$false
        Unregister-ScheduledTask -TaskName "FOIPinEnforcementDisable" -Confirm:$false
        Write-Success "titis anabechdis drois shezgudva gaukmebulia."
    }
    catch {
        Write-Error "titis anabechdis drois shezgudvis gaukmebisas moxda shecdoma: $_"
        Return-ToMenu
    }
    Return-ToMenu
}

function Reset-GPO {
    Write-Info "Mimdinareobs GPO-s gadatvirtva..."
    Remove-Item -Path "$env:SystemRoot\System32\GroupPolicy" -Recurse -Force -ErrorAction SilentlyContinue
    gpupdate /force
}

function Execute-LGPO {
    param(
        [Parameter(Mandatory=$true)]
        [string[]]$Arguments
    )
    Push-Location (Join-Path $ScriptDir "LGPO")
    & .\LGPO.exe $Arguments
    Pop-Location
}

function Save-GPO {
    Clear-Host
    Write-Info "Mimdinareobs sarezervo aslis shekmna..."
    try {
        $datetime = Get-Date -Format "yyyyMMdd_HHmmss"
        $backupDir = Join-Path $BackupBaseDir "backup_$datetime"

        if (-not (Test-Path $BackupBaseDir)) {
            New-Item -ItemType Directory -Path $BackupBaseDir | Out-Null
        }
        New-Item -ItemType Directory -Path $backupDir | Out-Null

        Write-Info "Iwyeba LGPO-is sarezervo aslis shekmna..."
        Execute-LGPO -Arguments @("/b", $backupDir)

        Write-Info "Mimdinareobs sarezervo monacemebis damushaveba..."
        Get-ChildItem -Path $backupDir -Recurse -Filter "*.pol" | ForEach-Object {
            Write-Info "Mushavdeba faili: $($_.Name)"
            $dirName = Split-Path -Parent $_.FullName | Split-Path -Leaf
            $outputFile = Join-Path $backupDir "$dirName.txt"
            Execute-LGPO -Arguments @("/parse", "/m", $_.FullName) > $outputFile
            Write-Info "Damushavebuli monacemebi shenaxulia: $outputFile"
        }

        Write-Success "Sarezervo aslebis shekmna dasrulda."
    }
    catch {
        Write-Error "Sarezervo aslis shekmnisas moxda shecdoma: $_"
        if (-not $Global:calledFromInstall) {
            Return-ToMenu
        }
        return $false
    }

    if (-not $Global:calledFromInstall) {
        Return-ToMenu
    }
    return $true
}

function Restore-GPO {
    Clear-Host
    Write-Info "Mimdinareobs sarezervo aslebis sia..."
    try {
        if (-not (Test-Path $BackupBaseDir)) {
            Write-Error "Sarezervo aslebis saqaghalde ar arsebobs: $BackupBaseDir"
            Return-ToMenu
        }

        $backups = Get-ChildItem -Path $BackupBaseDir -Directory | 
            Where-Object { $_.Name -match '^backup_\d{8}_\d{6}$' } |
            Sort-Object CreationTime -Descending |
            Select-Object -First 10

        if ($backups.Count -eq 0) {
            Write-Error "Sarezervo aslebi ver moidzebna"
            Return-ToMenu
        }

        Write-Host "`nBolo 10 sarezervo asli:"
        Write-Host "------------------------"
        for ($i = 0; $i -lt $backups.Count; $i++) {
            $backup = $backups[$i]
            $date = [DateTime]::ParseExact($backup.Name.Substring(7), "yyyyMMdd_HHmmss", $null)
            Write-Host "$largeText[$($i + 1)] $($date.ToString('yyyy-MM-dd HH:mm:ss'))$normalText"
        }

        Write-Host "`n$largeTextAirchiet sarezervo asli (1-$($backups.Count)):$normalText"
        $choice = Read-Host
        $index = [int]$choice - 1

        if ($index -lt 0 -or $index -ge $backups.Count) {
            Write-Error "Araswori archevani"
            Return-ToMenu
        }

        $selectedBackup = $backups[$index]
        Write-Info "Mimdinareobs sarezervo aslis aghdgena: $($selectedBackup.Name)..."

        Reset-GPO
        Execute-LGPO -Arguments @("/g", $selectedBackup.FullName)
        gpupdate /force

        Write-Success "Sarezervo aslis aghdgena dasrulda"
    }
    catch {
        Write-Error "Sarezervo aslis aghdgenisas moxda shecdoma: $_"
    }
    Return-ToMenu
}

function Install-GPO {
    Clear-Host
    $Global:calledFromInstall = $true
    if (-not (Save-GPO)) {
        $Global:calledFromInstall = $false
        Return-ToMenu
    }
    $Global:calledFromInstall = $false

    Write-Info "Mimdinareobs FOI usafrtxoebis politikis dayeneba..."
    try {
        Reset-GPO

        Write-Info "Parametrebis kopireba: '$ScriptDir\PolicyDefinitions' to '$env:SystemRoot\PolicyDefinitions\'"
        Copy-Item -Path "$ScriptDir\PolicyDefinitions\*" -Destination "$env:SystemRoot\PolicyDefinitions\" -Recurse -Force

        Get-ChildItem -Path (Join-Path $ScriptDir "LGPO\policy") -Directory | Select-Object -First 1 | ForEach-Object {
            Execute-LGPO -Arguments @("/g", $_.FullName)
        }

        Write-Info "Mimdinareobs FOI usafrtxoebis politikis dayeneba..."
        gpupdate /force
        Write-Success "FOI usafrtxoebis politikis dayeneba dasrulda."
    }
    catch {
        Write-Error "Usafrtxoebis politikis dayenebisas moxda shecdoma: $_"
        Return-ToMenu
    }
    Return-ToMenu
}

function Show-Menu {
    [Console]::BackgroundColor = 'Black'
    Write-Host ""
    Write-Host "$largeText__________________________________________________$normalText"
    Write-Host "$largeTextCopyright (C) 2024 FOI Georgia https://security.foi.ge$normalText"
    Write-Host ""
    Write-Host "$largeText       FOI Security Tools $normalText"
    Write-Host "$largeText     __________________________________________________$normalText"
    Write-Host ""
    Write-Host "$largeText       [1] FOI usafrtxoebis politikis dayeneba$normalText"
    Write-Host "$largeText       [2] PIN kodit shesvlis gaaktiureba$normalText"
    Write-Host "$largeText       [3] Titis anabechdis drois shezgudvis gaaktiureba$normalText"
    Write-Host "$largeText       [4] [EXPERT] PIN kodit shesvlis gaukmeba$normalText"
    Write-Host "$largeText       [5] [EXPERT] Titis anabechdis drois shezgudvis gaukmeba$normalText"
    Write-Host "$largeText       [6] [EXPERT] GPO-s shenaxva$normalText"
    Write-Host "$largeText       [7] [EXPERT] GPO-s agdgena$normalText"
    Write-Host "$largeText       [8] Gamosvla$normalText"
    Write-Host "$largeText     __________________________________________________$normalText"
    Write-Host ""
    Write-Host "$largeText       Airchiet operacia:$normalText"
    Write-Host ""
}

function Get-NextChoice {
    Write-Host "$largeText"
    $choice = Read-Host "Sheiyvanet tkveni archevani"
    Write-Host "$normalText"
    
    switch ($choice) {
        "1" { Install-GPO }
        "2" { Enforce-PINLogin }
        "3" { Enforce-FingerprintTimeout }
        "4" { Disable-PINLogin }
        "5" { Disable-FingerprintTimeout }
        "6" { Save-GPO }
        "7" { Restore-GPO }
        "8" { 
            Write-Host "Programidan gamosvla..."
            Start-Sleep -Seconds 1
            Stop-Process $pid
        }
        default { 
            Write-Error "Araswori archevani. Gtxovt scadot xelaxla"
            Return-ToMenu
        }
    }
}

# Main loop
Clear-Host
while ($true) {
    Show-Menu
    Get-NextChoice
}
