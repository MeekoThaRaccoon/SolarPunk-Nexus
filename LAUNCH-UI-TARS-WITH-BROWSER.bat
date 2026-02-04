@echo off
echo ========================================
echo LAUNCHING UI-TARS WITH BROWSER
echo ========================================
echo.
echo Starting development server...
echo Will open browser in 10 seconds...
echo.

cd /d "C:\Users\carol\UI-TARS-desktop\apps\desktop"

:: Start dev server in background
start /B pnpm run dev

:: Wait for server to start
timeout /t 10 /nobreak >nul

:: Try common development ports
start http://localhost:3000
start http://localhost:5173
start http://localhost:8080

echo.
echo Browser windows opened. Check if UI-TARS is running.
echo If not, check the terminal window that opened.
echo.
echo KEEP THIS WINDOW OPEN for the server.
echo.
pause