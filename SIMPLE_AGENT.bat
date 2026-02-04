@echo off
:menu
cls
echo ========================================
echo SOLARPUNK SIMPLE AGENT v1.0
echo ========================================
echo.
echo 1. Check System Status
echo 2. Deploy Website
echo 3. Push to GitHub
echo 4. Open Cloudflare
echo 5. Open GitHub
echo 6. Open UI-TARS Folder
echo 7. Exit
echo.
set /p choice="Choose (1-7): "

if "%choice%"=="1" goto status
if "%choice%"=="2" goto deploy
if "%choice%"=="3" goto push
if "%choice%"=="4" goto cloudflare
if "%choice%"=="5" goto github
if "%choice%"=="6" goto uitars
if "%choice%"=="7" exit

:status
cls
echo === SYSTEM STATUS ===
echo.
cd /d "C:\Users\carol\SolarPunk\connected\SolarPunk-Autonomous"
git remote -v
echo.
echo Website: https://solarpunkagent.pages.dev
echo Cloudflare: https://dash.cloudflare.com
echo GitHub: https://github.com/MeekoThaRaccoon
echo.
pause
goto menu

:deploy
cls
echo === DEPLOY WEBSITE ===
echo.
echo Copying files from dist...
xcopy /Y "C:\Users\carol\SolarPunk\dist\*" "C:\Users\carol\SolarPunk\connected\SolarPunk-Autonomous\dist\"
echo.
echo Files copied. Ready to push.
pause
goto menu

:push
cls
echo === PUSH TO GITHUB ===
echo.
cd /d "C:\Users\carol\SolarPunk\connected\SolarPunk-Autonomous"
git add .
git commit -m "Update: %date% %time%"
git push origin master
echo.
echo Pushed! Cloudflare will auto-deploy.
pause
goto menu

:cloudflare
start https://solarpunkagent.pages.dev
start https://dash.cloudflare.com
goto menu

:github
start https://github.com/MeekoThaRaccoon/SolarPunk-Autonomous
goto menu

:uitars
cd /d "C:\Users\carol\UI-TARS-desktop"
explorer .
goto menu