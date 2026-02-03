@echo off
chcp 65001 > nul
title Fix All Batch Files
color 0A

echo.
echo ========================================
echo       FIXING BATCH FILE ENCODING
echo ========================================
echo.

echo Creating clean batch files without BOM...

:: Create START.bat
echo @echo off > START.bat
echo chcp 65001 ^> nul >> START.bat
echo title SolarPunk Agent >> START.bat
echo color 0A >> START.bat
echo. >> START.bat
echo echo Running agent... >> START.bat
echo python ultimate_agent.py >> START.bat
echo pause >> START.bat

:: Create PUSH.bat
echo @echo off > PUSH.bat
echo chcp 65001 ^> nul >> PUSH.bat
echo title SolarPunk Deploy >> PUSH.bat
echo color 0A >> PUSH.bat
echo. >> START.bat
echo git add . 2^>nul >> PUSH.bat
echo git commit -m "Auto-update %%date%% %%time%%" 2^>nul ^|^| echo No changes >> PUSH.bat
echo git push origin master 2^>nul >> PUSH.bat
echo echo Deploy complete! >> PUSH.bat
echo pause >> PUSH.bat

:: Create TEST.bat to verify
echo @echo off > TEST.bat
echo echo Batch file test SUCCESS > TEST.bat
echo pause >> TEST.bat

echo.
echo Created:
echo - START.bat
echo - PUSH.bat  
echo - TEST.bat
echo.
echo Double-click TEST.bat to verify it works.
echo.
pause
