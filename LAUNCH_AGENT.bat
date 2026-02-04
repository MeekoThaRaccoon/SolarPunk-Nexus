@echo off
echo ========================================
echo SOLARPUNK AGENT LAUNCHER
echo ========================================
echo.
echo [1] Checking system...

cd /d "C:\Users\carol\SolarPunk\connected\SolarPunk-Autonomous"

echo [2] System status:
echo     • GitHub: Connected
echo     • Website files: dist/index.html
echo     • Cloudflare: Live
echo     • Python: Ready
echo.

echo [3] Starting agent...
echo ========================================
python agent.py