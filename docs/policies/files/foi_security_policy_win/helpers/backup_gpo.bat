@echo off
setlocal enabledelayedexpansion
set "ScriptDir=%~dp0..\"

if exist "%ScriptDir%\LGPO\backup" (
    rmdir /s /q "%ScriptDir%\LGPO\backup"
    echo Directory LGPO\backup removed
) else (
    echo Directory LGPO\backup does not exist
)

cd "%ScriptDir%\LGPO\"

mkdir "backup"

echo Starting LGPO backup...
.\LGPO.exe /b "%ScriptDir%\LGPO\backup"
echo Backup completed.

echo Parsing backup data...
set "BackupPath=%ScriptDir%\LGPO\backup"

:: Process each .pol file and save the output to a txt file named after the directory
for /r "%BackupPath%" %%f in (*.pol) do (
    echo Processing file: %%~nxf
    :: Extract the directory name
    for %%d in ("%%~pf.") do set "DirName=%%~nxd"
    set "OutputFile=!ScriptDir!\LGPO\backup\!DirName!.txt"
    .\LGPO.exe /parse /m "%%f" > "!OutputFile!"
    echo Parsed data saved to: !OutputFile!
)

echo All backup data has been parsed and saved.

pause