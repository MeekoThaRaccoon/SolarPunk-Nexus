@echo off
echo ========= SOLARPUNK FIX =========
echo.
cd /d "C:\Users\carol\SolarPunk\connected\SolarPunk-Autonomous"

echo [1] Checking Git remote...
git remote -v
if %errorlevel% neq 0 (
    echo ERROR: No Git remote found!
    echo.
    echo You need to connect to GitHub:
    echo 1. Go to: https://github.com/new
    echo 2. Create repository: SolarPunk-Autonomous
    echo 3. Copy the URL it gives you
    echo 4. Run this command:
    echo    git remote add origin YOUR_URL_HERE
    pause
    exit
)

echo [2] Committing changes...
git add .
git commit -m "System update: %date% %time%"

echo [3] Pushing to GitHub...
git push origin master

echo [4] Checking Cloudflare deployment...
curl -I https://solarpunk-nexus.pages.dev

echo.
echo ========= WHAT'S NEXT =========
echo 1. Install Cloudflare App: https://github.com/apps/cloudflare-pages
echo 2. Visit: https://solarpunk-nexus.pages.dev
echo 3. Run your Memvid upload script
pause