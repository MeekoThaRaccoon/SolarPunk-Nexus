@echo off
echo === SOLARPUNK DEBUG MODE ===
echo.
cd /d "C:\Users\carol\SolarPunk\connected\SolarPunk-Autonomous"
echo Current directory: %cd%
echo.
echo Testing Python...
python --version
echo.
echo Testing agent.py...
python agent.py
echo.
echo Exit code: %errorlevel%
echo.
pause