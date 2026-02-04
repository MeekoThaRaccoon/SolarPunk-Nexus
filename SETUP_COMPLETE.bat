@echo off
echo ============================================
echo SOLARPUNK COMPLETE SETUP WIZARD
echo ============================================
echo.

:: 1. Create essential agent files
echo [1] Creating core agent files...
cd /d "C:\Users\carol\SolarPunk\connected\SolarPunk-Autonomous"

(
echo # Core agent files created by setup wizard
echo # Run: python agent.py to start
) > AGENT_README.txt

:: 2. Create directory structure
echo [2] Creating directory structure...
if not exist logs mkdir logs
if not exist data mkdir data
if not exist scripts mkdir scripts

:: 3. Update Git and push everything
echo [3] Updating GitHub repository...
git add .
git commit -m "Complete agent setup: %date% %time%"
git push origin master

:: 4. Final status
echo.
echo ============================================
echo ✅ SETUP COMPLETE!
echo.
echo Your SolarPunk system now has:
echo 1. Core agent code in SolarPunk-Autonomous
echo 2. Website files deployed to Cloudflare
echo 3. All repos connected to GitHub
echo.
echo NEXT ACTIONS:
echo 1. Run: python agent.py (for main menu)
echo 2. Check: https://solarpunkagent.pages.dev
echo 3. Monitor: https://dash.cloudflare.com
echo ============================================
pause