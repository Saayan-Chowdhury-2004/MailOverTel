```bat id="sz7q4m"
@echo off

title MailOverTel Installer

echo ============================================
echo           MailOverTel Installer
echo ============================================
echo.

:: ============================================
:: CHECK PYTHON
:: ============================================

echo Checking Python...

python --version >nul 2>&1

IF %ERRORLEVEL% NEQ 0 (

    echo.
    echo Python is not installed.
    echo Opening Python download page...
    start https://www.python.org/downloads/

    echo.
    echo Install Python and run this installer again.
    pause
    exit
)

echo Python detected.
echo.

:: ============================================
:: CHECK DOCKER
:: ============================================

echo Checking Docker...

docker --version >nul 2>&1

IF %ERRORLEVEL% NEQ 0 (

    echo.
    echo Docker Desktop is not installed.
    echo Opening Docker download page...
    start https://www.docker.com/products/docker-desktop/

    echo.
    echo Install Docker Desktop and run this installer again.
    pause
    exit
)

echo Docker detected.
echo.

:: ============================================
:: CHECK OLLAMA
:: ============================================

echo Checking Ollama...

ollama --version >nul 2>&1

IF %ERRORLEVEL% NEQ 0 (

    echo.
    echo Ollama is not installed.
    echo Opening Ollama download page...
    start https://ollama.com/download

    echo.
    echo Install Ollama and run this installer again.
    pause
    exit
)

echo Ollama detected.
echo.

:: ============================================
:: INSTALL PYTHON DEPENDENCIES
:: ============================================

echo Installing Python dependencies...

pip install -r requirements.txt

echo.
echo Python dependencies installed.
echo.

:: ============================================
:: CHECK AI MODEL
:: ============================================

echo Checking AI model...

ollama list | findstr "llama3:8b"

IF %ERRORLEVEL% NEQ 0 (

    echo.
    echo Downloading llama3:8b model...
    ollama pull llama3:8b
)

echo.
echo AI model ready.
echo.

:: ============================================
:: CREATE .ENV FILE IF MISSING
:: ============================================

IF NOT EXIST .env (

    echo No .env file found.

    IF EXIST .env.template (

        copy .env.template .env

        echo.
        echo ============================================
        echo .env file created successfully.
        echo ============================================
        echo.

        echo Please open the .env file and fill:
        echo.
        echo TELEGRAM_TOKEN
        echo EMAIL
        echo APP_PASSWORD
        echo SENDER_NAME
        echo.

        pause
    )
)

:: ============================================
:: START OLLAMA
:: ============================================

echo Starting Ollama...

start /B ollama serve

timeout /t 5 >nul

echo Ollama started.
echo.

:: ============================================
:: BUILD DOCKER CONTAINER
:: ============================================

echo Building Docker container...

docker compose build

echo.
echo Docker build complete.
echo.

:: ============================================
:: START CONTAINER
:: ============================================

echo Starting MailOverTel...

docker compose up -d

echo.
echo ============================================
echo      MailOverTel Installed Successfully
echo ============================================
echo.

echo MailOverTel will now run automatically
echo in the background through Docker.

echo.
echo You can now use the Telegram mobile app
echo to send emails naturally.

echo.
echo Example:
echo Send an email to xyz@gmail.com
echo telling them to attend tomorrow's meeting.
echo.

echo IMPORTANT:
echo Enable Docker Desktop auto-start in:
echo Docker Desktop ^> Settings ^> General
echo ^> Start Docker Desktop when you log in
echo.

pause
```
