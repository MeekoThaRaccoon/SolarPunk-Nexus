@echo off 
chcp 65001 > nul 
title SolarPunk Deploy 
color 0A 
git add . 2>nul 
git commit -m "Auto-update %date% %time%" 2>nul || echo No changes 
git push origin master 2>nul 
echo Deploy complete! 
pause 
