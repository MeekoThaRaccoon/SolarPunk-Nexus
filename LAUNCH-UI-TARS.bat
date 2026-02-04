@echo off
echo ========================================
echo LAUNCHING UI-TARS
echo ========================================
echo.
echo Starting UI-TARS development server...
echo This is the powerful GUI automation agent.
echo.
echo Once started, open your browser to the URL shown below.
echo Common URLs: http://localhost:3000 or http://localhost:5173
echo.
echo KEEP THIS WINDOW OPEN while using UI-TARS.
echo Press Ctrl+C to stop when done.
echo ========================================
echo.

cd /d "C:\Users\carol\UI-TARS-desktop\apps\ui-tars"
pnpm run dev

pause