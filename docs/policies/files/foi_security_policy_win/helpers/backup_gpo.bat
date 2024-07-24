@echo off
set "ScriptDir=%~dp0..\"

if exist "%ScriptDir%\LGPO\backup" (
    rmdir /s /q "%ScriptDir%\LGPO\backup"
    echo Directory LGPO\backup removed
) else (
    echo Directory LGPO\backup does not exist
)

cd "%ScriptDir%\LGPO\"

mkdir "backup"

.\LGPO.exe /b "%ScriptDir%\LGPO\backup"
pause