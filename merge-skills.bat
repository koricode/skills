@echo off
setlocal enabledelayedexpansion

rem merge-skills.bat
rem
rem Moves every folder inside .agents\skills\ into skills\.
rem If a folder with the same name already exists in skills\, it is removed
rem (including all its contents) before the new one is moved in.
rem Afterwards, the .agents\ folder and skills-lock.json are deleted.

rem Resolve paths relative to this script's location, so it can be run from anywhere.
set "SCRIPT_DIR=%~dp0"
set "SRC_DIR=%SCRIPT_DIR%.agents\skills"
set "DEST_DIR=%SCRIPT_DIR%skills"
set "AGENTS_DIR=%SCRIPT_DIR%.agents"
set "LOCK_FILE=%SCRIPT_DIR%skills-lock.json"

rem Sanity check.
if not exist "%SRC_DIR%\" (
  echo Error: source directory not found: %SRC_DIR% 1>&2
  exit /b 1
)

if not exist "%DEST_DIR%\" mkdir "%DEST_DIR%"

rem Move each top-level folder from .agents\skills\ into skills\.
for /d %%D in ("%SRC_DIR%\*") do (
  set "name=%%~nxD"
  set "dest=%DEST_DIR%\!name!"

  if exist "!dest!\" (
    echo Removing existing: !dest!
    rmdir /s /q "!dest!"
  )

  echo Moving: !name! -^> skills\
  move "%%~fD" "!dest!" >nul
)

rem Clean up.
echo Removing: %AGENTS_DIR%
rmdir /s /q "%AGENTS_DIR%"

if exist "%LOCK_FILE%" (
  echo Removing: %LOCK_FILE%
  del /q "%LOCK_FILE%"
)

echo Done.
endlocal