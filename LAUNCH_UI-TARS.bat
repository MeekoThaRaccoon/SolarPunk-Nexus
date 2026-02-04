@echo off
echo ========================================
echo LAUNCHING UI-TARS DESKTOP
echo ========================================
echo.
echo This is a powerful GUI automation agent from ByteDance.
echo It can control browsers, desktops, and automate tasks.
echo.

cd /d "C:\Users\carol\UI-TARS-desktop"

echo Looking for application files...
dir *.exe /b

if exist "UI-TARS-Desktop.exe" (
    echo Found executable, launching...
    start "" "UI-TARS-Desktop.exe"
) else if exist "setup.exe" (
    echo Found setup, launching...
    start "" "setup.exe"
) else if exist "install.exe" (
    echo Found installer, launching...
    start "" "install.exe"
) else (
    echo No executable found. Let's explore the folder...
    explorer .
    echo.
    echo LOOK FOR:
    echo 1. Any .exe files
    echo 2. README.md or INSTALL.md
    echo 3. package.json (if it's Node.js)
    echo 4. A "dist" or "build" folder
)

echo.
echo ========================================
echo TIPS:
echo 1. Check README.md for setup instructions
echo 2. Look for a "Release" folder with downloads
echo 3. Check: https://github.com/bytedance/UI-TARS-desktop/releases
echo ========================================
pause