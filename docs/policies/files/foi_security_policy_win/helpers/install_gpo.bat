@echo off
set "ScriptDir=%~dp0.."

echo Copying definitions from: "%ScriptDir%\PolicyDefinitions" to "%SystemRoot%\PolicyDefinitions\"

xcopy /S /Y "%ScriptDir%\PolicyDefinitions" "%SystemRoot%\PolicyDefinitions\"

cd "%ScriptDir%\LGPO"

:: Find the first directory in the backup subdirectory and use it for LGPO.exe
for /D %%D in ("%ScriptDir%\LGPO\backup\*") do (
    echo Applying group policies...

    .\LGPO.exe /g "%%D"
    :: Only process the first directory
    goto :process_complete
)

:process_complete
:: Force update of group policy
echo Updating group policies...
gpupdate /force

pause