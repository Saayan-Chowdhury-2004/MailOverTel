@echo off

echo ========================================
echo MailOverTel Installer
echo ========================================

echo.

echo Checking Python...
python --version >nul 2>&1

IF %ERRORLEVEL% NEQ 0 (
    echo Python is not installed.
    echo Please install Python first.
    pause
    exit
)

echo Python found.
echo.

echo Checking Docker...
docker --version >nul 2>&1

IF %ERRORLEVEL% NEQ 0 (
    echo Docker Desktop is not installed.
    echo Please install Docker Desktop first.
    pause
    exit
)

echo Docker found.
echo.

echo Checking Ollama...
ollama --version >nul 2>&1

IF %ERRORLEVEL% NEQ 0 (
    echo Ollama is not installed.
    echo Please install Ollama first.
    pause
    exit
)

echo Ollama found.
echo.

echo Installing Python dependencies...
pip install -r requirements.txt

echo.

echo Checking AI model...
ollama list | findstr "llama3:8b"

IF %ERRORLEVEL% NEQ 0 (
    echo Pulling llama3:8b model...
    ollama pull llama3:8b
)

echo.

IF NOT EXIST .env (
    echo No .env file found.

    IF EXIST .env.template (
        copy .env.template .env
        echo Created .env from template.
    )
)

echo.
echo ========================================
echo Installation Complete
echo ========================================
echo.

echo Please edit the .env file before starting.
echo.

pause