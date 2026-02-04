@echo off
echo ========================================
echo SOLARPUNK WEBSITE DEPLOYMENT
echo ========================================
echo.

:: 1. GO TO THE RIGHT PLACE
cd /d "C:\Users\carol\SolarPunk\connected\SolarPunk-Autonomous"
echo [1] In SolarPunk-Autonomous folder...

:: 2. RESET GIT REMOTE (No more confusion)
echo [2] Resetting Git remote...
git remote remove origin 2>nul
git remote add origin https://github.com/MeekoThaRaccoon/SolarPunk-Autonomous.git

:: 3. COPY THE CORRECT WEBSITE FILES
echo [3] Copying website files from main dist folder...
xcopy /Y "C:\Users\carol\SolarPunk\dist\*" "dist\"

:: 4. COMMIT EVERYTHING
echo [4] Committing all changes...
git add --all
git commit -m "Deploy website: %date% %time%"

:: 5. PUSH TO GITHUB (FORCE IF NEEDED)
echo [5] Pushing to GitHub...
git push --force origin master

:: 6. REPORT STATUS
echo.
echo ========================================
if %errorlevel% EQU 0 (
    echo ✅ SUCCESS! Deployment sent to GitHub.
    echo.
    echo WHAT HAPPENS NEXT:
    echo 1. Cloudflare will auto-detect this push
    echo 2. It will deploy from: SolarPunk-Autonomous/dist/
    echo 3. Your site updates in ~2 minutes
    echo.
    echo CHECK THESE LINKS:
    echo - GitHub:   https://github.com/MeekoThaRaccoon/SolarPunk-Autonomous
    echo - Cloudflare: https://dash.cloudflare.com/
    echo - Your Site:   https://solarpunkagent.pages.dev
) else (
    echo ❌ PUSH FAILED. Check Git output above.
)

echo ========================================
pause