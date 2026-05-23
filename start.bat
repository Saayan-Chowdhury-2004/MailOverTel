@echo off

echo ========================================
echo Starting MailOverTel
echo ========================================

echo.

start /B ollama serve

docker compose up -d

echo.
echo MailOverTel is now running.
echo Open Telegram and start messaging your bot.
echo.

pause