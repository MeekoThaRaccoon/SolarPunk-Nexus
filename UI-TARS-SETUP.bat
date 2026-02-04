@echo off
echo ========================================
echo UI-TARS DESKTOP SETUP WIZARD
echo ========================================
echo.
echo This will guide you through building UI-TARS from source.
echo You have ALL the files - we just need to build them.
echo.

:menu
cls
echo ========================================
echo STEP 1: INSTALL PREREQUISITES
echo ========================================
echo.
echo Before building, you need:
echo 1. Node.js (JavaScript runtime)
echo 2. pnpm (Package manager)
echo 3. Git (already have it)
echo.
echo Have you installed Node.js? (y/n): 
set /p node_installed=

if "%node_installed%"=="y" goto check_node
if "%node_installed%"=="n" goto install_node

:install_node
echo.
echo INSTALLING NODE.JS:
echo 1. Open: https://nodejs.org/
echo 2. Download "LTS" version (22.x or higher)
echo 3. Run the installer (default settings)
echo 4. RESTART your computer after installing
echo.
echo After installing and restarting, run this script again.
pause
exit

:check_node
echo.
echo Checking Node.js installation...
node --version
if %errorlevel% neq 0 (
    echo ❌ Node.js not found. Please install it first.
    pause
    goto install_node
)

echo ✅ Node.js is installed!
echo.
echo Checking pnpm...
pnpm --version
if %errorlevel% neq 0 (
    echo Installing pnpm...
    npm install -g pnpm
)

echo.
echo ========================================
echo STEP 2: INSTALL DEPENDENCIES
echo ========================================
echo This will install all required packages.
echo It may take 5-15 minutes. Don't close the window!
echo.
echo Press any key to continue...
pause >nul

cd /d "C:\Users\carol\UI-TARS-desktop"
echo Installing dependencies with pnpm...
pnpm install

if %errorlevel% neq 0 (
    echo ❌ Installation failed. Check errors above.
    pause
    exit
)

echo ✅ Dependencies installed!
echo.
echo ========================================
echo STEP 3: FIND THE DESKTOP APP
echo ========================================
echo Looking for the desktop application...
echo.

dir apps /b

echo.
echo Which app do you see? Type the folder name:
set /p app_name=

:build
echo.
echo ========================================
echo STEP 4: BUILD THE APP
echo ========================================
echo Building %app_name%...
echo This may take 2-10 minutes...
echo.

cd apps\%app_name%
pnpm run build

if %errorlevel% neq 0 (
    echo ❌ Build failed. Trying alternative...
    pnpm run build:win
)

echo.
echo ========================================
echo STEP 5: RUN THE APP
echo ========================================
echo.
echo Looking for the built application...
dir dist /b 2>nul
dir build /b 2>nul
dir release /b 2>nul

echo.
echo If you see an .exe file, you can run it.
echo Otherwise, try: pnpm run dev (for development)
echo.
echo 1. Run in dev mode
echo 2. Exit
echo.
set /p run_choice="Choice (1-2): "

if "%run_choice%"=="1" (
    echo Starting in development mode...
    pnpm run dev
) else (
    echo.
    echo Setup complete! Check for .exe files in:
    echo C:\Users\carol\UI-TARS-desktop\apps\%app_name%\dist\
    echo OR
    echo C:\Users\carol\UI-TARS-desktop\apps\%app_name%\build\
    echo.
    echo You can also try: pnpm run dev
)

pause