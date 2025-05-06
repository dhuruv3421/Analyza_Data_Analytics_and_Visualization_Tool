@echo off
echo Checking if port 8080 is in use...

REM Check if port 8080 is already in use
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :8080 ^| findstr LISTENING') do (
    echo Port 8080 is already in use by PID %%a
    echo Please close the conflicting application or use Task Manager to stop PID %%a.
    pause
    exit /b
)

echo Starting Analyza Frontend and Backend...

REM Save current directory and move to script location
pushd %~dp0

REM Start frontend in a new terminal window
start cmd /k "cd /d %cd%\Frontend\Dashboard && npm run dev"

REM Start backend in another new terminal window
start cmd /k "cd /d %cd%\Backend && python -m uvicorn main:app --host 0.0.0.0 --port 8080 --reload"

REM Return to original directory
popd

echo Both frontend and backend are starting...
pause
