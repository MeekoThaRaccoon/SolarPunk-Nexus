@echo off
chcp 65001 > nul
title Create Test Repositories
color 0A

echo.
echo ╔══════════════════════════════════════════════════╗
echo ║         CREATING TEST REPOSITORIES               ║
echo ╚══════════════════════════════════════════════════╝
echo.

echo 📂 Creating connected folder structure...
mkdir connected 2>nul
cd connected

echo 📁 Creating SolarPunk-Nexus test repo...
mkdir SolarPunk-Nexus 2>nul
cd SolarPunk-Nexus

echo # SolarPunk-Nexus > README.md
echo This is a test repository for error scanning. >> README.md
echo. >> README.md
echo ## Issues: >> README.md
echo - Missing .git folder >> README.md
echo - No Python files >> README.md

echo __pycache__/ > .gitignore
echo *.pyc >> .gitignore

cd..

echo 📁 Creating SolarPunk-Autonomous test repo...
mkdir SolarPunk-Autonomous 2>nul
cd SolarPunk-Autonomous

echo # SolarPunk-Autonomous > README.md
echo Main agent repository. >> README.md

echo print("This has a syntax error" > broken.py
echo import nonexistent_module > import_error.py

echo __pycache__/ > .gitignore

cd..\..

echo.
echo ✅ Created 2 test repositories in connected/
echo 📁 Open connected/ folder to see them
echo.
echo 🔍 Now run: python error_scanner.py
echo.
pause