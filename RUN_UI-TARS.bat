@echo off
echo ========================================
echo UI-TARS DESKTOP LAUNCHER
echo ========================================
echo.
echo If you see errors, follow these steps:
echo.
echo 1. Install Node.js (https://nodejs.org/)
echo 2. Open PowerShell as Administrator
echo 3. Run: npm install -g pnpm
echo 4. Run: cd C:\Users\carol\UI-TARS-desktop
echo 5. Run: pnpm install
echo 6. Look for "desktop" app in /apps folder
echo.

cd /d "C:\Users\carol\UI-TARS-desktop"

echo Checking for desktop app...
dir apps\*desktop* /s /b

echo.
echo ========================================
echo QUICK START:
echo 1. Open PowerShell in this folder
echo 2. Run: pnpm install
echo 3. Check README for specific build instructions
echo ========================================
pause