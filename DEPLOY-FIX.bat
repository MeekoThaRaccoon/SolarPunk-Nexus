@echo off
echo ONE-CLICK DEPLOYMENT FIX
echo.

cd /d C:\Users\carol\SolarPunk

echo 1. Pull latest changes...
git pull origin main

echo 2. Install dependencies...
npm install

echo 3. Build project...
npm run build

echo 4. Deploy to Cloudflare...
npx wrangler pages deploy dist --project-name=solarpunkagent

echo.
echo Deployment complete! Check:
start https://solarpunkagent.pages.dev
start https://dash.cloudflare.com

pause