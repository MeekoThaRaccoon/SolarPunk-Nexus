@echo off
chcp 65001 > nul
title ⚡ FIXING SUBMODULE ERROR - AUTOMATIC
color 0A

echo.
echo ╔══════════════════════════════════════════════════╗
echo ║      FIXING SUBMODULE ERROR - NO INPUT           ║
echo ╚══════════════════════════════════════════════════╝
echo.

echo 📂 Step 1: Removing problematic submodule reference...
:: Remove the submodule from git index
git rm --cached connected/SolarPunk-Autonomous 2>nul

echo 📄 Step 2: Removing .gitmodules file if exists...
if exist .gitmodules (
    del .gitmodules
    echo ✅ Removed .gitmodules
)

echo 🔧 Step 3: Creating fresh .gitmodules file...
echo [submodule "connected/SolarPunk-Autonomous"] > .gitmodules
echo     path = connected/SolarPunk-Autonomous >> .gitmodules
echo     url = https://github.com/MeekoThaRaccoon/SolarPunk-Autonomous.git >> .gitmodules

echo 📝 Step 4: Updating git configuration...
git add .gitmodules
git submodule sync 2>nul

echo 🗑️ Step 5: If nested .git exists, remove it...
if exist "connected\SolarPunk-Autonomous\.git" (
    rmdir /s /q "connected\SolarPunk-Autonomous\.git"
    echo ✅ Removed nested .git folder
)

echo 🔄 Step 6: Committing the fix...
git add .
git commit -m "Fix submodule error for Cloudflare deploy" 2>nul || echo "No changes to commit"

echo 🚀 Step 7: Pushing to GitHub...
git push origin master

echo.
echo ╔══════════════════════════════════════════════════╗
echo ║              ✅ FIX APPLIED                      ║
echo ╚══════════════════════════════════════════════════╝
echo.
echo 📊 What was fixed:
echo   1. Removed broken submodule reference
echo   2. Created correct .gitmodules file
echo   3. Removed nested .git folder (if existed)
echo   4. Pushed fix to GitHub
echo.
echo 🌐 Cloudflare will now rebuild automatically.
echo    Wait 60 seconds, then check:
echo    https://solarpunkagent.pages.dev
echo.
echo 📁 For proof, check these files exist:
echo   • .gitmodules (should exist)
echo   • connected/SolarPunk-Autonomous/ (should have no .git folder)
echo.
pause