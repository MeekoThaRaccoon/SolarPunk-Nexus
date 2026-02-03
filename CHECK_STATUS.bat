@echo off
chcp 65001 > nul
title ⚡ SolarPunk Status Check
color 0A

echo.
echo ╔══════════════════════════════════════════════════╗
echo ║            SOLARPUNK SYSTEM STATUS               ║
echo ╚══════════════════════════════════════════════════╝
echo.

echo 📂 Checking folders...
if exist connected (echo   ✅ connected) else (echo   ❌ connected)
if exist dist (echo   ✅ dist) else (echo   ❌ dist)
if exist logs (echo   ✅ logs) else (echo   ❌ logs)
if exist scripts (echo   ✅ scripts) else (echo   ❌ scripts)

echo.
echo 📄 Checking essential files...
if exist START.bat (echo   ✅ START.bat) else (echo   ❌ START.bat)
if exist PUSH.bat (echo   ✅ PUSH.bat) else (echo   ❌ PUSH.bat)
if exist agent_simple.py (echo   ✅ agent_simple.py) else (echo   ❌ agent_simple.py)
if exist dist\index.html (echo   ✅ dist\index.html) else (echo   ❌ dist\index.html)

echo.
echo 🔧 Checking Git...
git --version 2>nul && echo   ✅ Git installed || echo   ❌ Git not found

echo.
echo 🐍 Checking Python...
python --version 2>nul && echo   ✅ Python installed || echo   ❌ Python not found

echo.
echo 🌐 Checking Cloudflare site...
curl -s -o nul -w "%%{http_code}" https://solarpunkagent.pages.dev
if errorlevel 1 (echo   ❌ Cannot reach Cloudflare) else (echo   ✅ Cloudflare site accessible)

echo.
echo 📊 Checking GitHub connection...
git remote -v 2>nul && echo   ✅ GitHub remote set || echo   ❌ GitHub remote not set

echo.
echo ⚡ Checking agent...
if exist agent_simple.py (
    python agent_simple.py 2>nul && echo   ✅ Agent runs || echo   ❌ Agent has errors
)

echo.
echo ====================================================
echo If all checks are ✅, your system is ready.
echo If any ❌, run FIX_ALL.bat again or ask for help.
echo ====================================================
echo.
pause