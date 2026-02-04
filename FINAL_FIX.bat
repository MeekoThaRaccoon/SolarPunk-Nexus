@echo off
echo ========================================
echo SOLARPUNK FINAL GIT RESET
echo ========================================
echo.

:: 1. GO TO SOLARPUNK-AUTONOMOUS
cd /d "C:\Users\carol\SolarPunk\connected\SolarPunk-Autonomous"
echo [1] In SolarPunk-Autonomous folder...

:: 2. BACKUP ANY LOCAL CHANGES FIRST
echo [2] Backing up local changes...
if exist dist_backup rmdir /s /q dist_backup
if exist dist xcopy /E /I dist dist_backup 2>nul

:: 3. RESET GIT COMPLETELY
echo [3] Resetting Git history...
git checkout --orphan new_branch
git add -A
git commit -m "Clean slate: Complete SolarPunk system"
git branch -D master
git branch -m master

:: 4. SET CORRECT REMOTE
echo [4] Setting remote to GitHub...
git remote remove origin 2>nul
git remote add origin https://github.com/MeekoThaRaccoon/SolarPunk-Autonomous.git

:: 5. FORCE PUSH (OVERWRITES EVERYTHING ON GITHUB)
echo [5] Force pushing to GitHub...
git push -f origin master

:: 6. RESTORE WEBSITE FILES
echo [6] Restoring website files...
if exist dist_backup (
    if exist dist rmdir /s /q dist
    xcopy /E /I dist_backup dist 2>nul
    rmdir /s /q dist_backup
)

:: 7. COMMIT WEBSITE FILES
echo [7] Committing website files...
git add .
git commit -m "Add website files: %date% %time%"
git push origin master

:: 8. FINAL STATUS
echo.
echo ========================================
if %errorlevel% EQU 0 (
    echo ✅ SUCCESS! Complete reset and push.
    echo.
    echo WHAT JUST HAPPENED:
    echo 1. Created new Git history (clean slate)
    echo 2. Force pushed to overwrite GitHub
    echo 3. Restored your website files
    echo 4. Final push with all current files
    echo.
    echo CHECK NOW:
    echo 1. GitHub:   https://github.com/MeekoThaRaccoon/SolarPunk-Autonomous
    echo 2. Wait 2 mins for Cloudflare auto-deploy
    echo 3. Site:     https://solarpunkagent.pages.dev
) else (
    echo ❌ Something failed at step above.
    echo Check error message.
)

echo ========================================
echo.
echo Run agent: python agent.py
pause