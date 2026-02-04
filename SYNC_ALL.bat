@echo off 
cd /d "C:\Users\carol\SolarPunk" 
echo 🔄 Auto-sync at %date% %time% 
git add . 
git commit -m "Auto-sync %date% %time%" 
git push origin master 
echo ✅ Synced to GitHub 
Cloudflare will auto-deploy in 30s 
pause 
