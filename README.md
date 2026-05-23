# 📬 MailOverTel

A self-hosted AI-powered email automation system that converts natural language prompts into properly structured emails and sends them automatically through Telegram.

---

## 1) Overview

MailOverTel is designed to simplify email automation using natural language.

Instead of manually opening an email client, formatting messages and sending emails one by one, users can simply message a Telegram bot naturally.

Example:

```text
Send an email to xyz@gmail.com telling them to attend tomorrow's meeting.
```

MailOverTel automatically:

* Understands the request
* Generates a human-like email
* Structures the email properly
* Extracts recipient details
* Sends the email autonomously

The system is built using:

* Python
* Ollama
* Gemma4
* Docker
* Telegram Bot API
* Gmail SMTP

and is designed to function as a lightweight self-hosted AI assistant focused on practical real-world automation.

---

## 2) Features

### 🔹 Core

* AI-powered email generation
* Telegram-based interaction
* Natural language instructions
* Human-like email formatting
* Automatic recipient extraction
* Gmail SMTP integration

### 🔹 Advanced

* Dockerized deployment
* Self-hosted local inference using Ollama
* Background runtime architecture
* Telegram mobile app supported

---

## 3) Project Structure

```text
MailOverTel/
│── bot.py                  # Core backend logic
│── setup.bat               # One-click setup + deployment
│── Dockerfile              # Docker environment definition
│── docker-compose.yml      # Docker service management
│── requirements.txt        # Python dependencies
│── .env.template           # Environment variable template
│── .gitignore
│── README.md
```

---

## 4) Installation

### Clone Repository

```bash
git clone https://github.com/Saayan-Chowdhury-2004/MailOverTel.git

cd MailOverTel
```

---

### Run Setup

Double click:

```text
setup.bat
```

The setup file automatically:

* Checks if Python is installed
* Checks if Docker Desktop is installed
* Checks if Ollama is installed
* Opens official installers if something is missing
* Installs required Python packages
* Downloads the required AI model
* Builds Docker containers
* Starts MailOverTel automatically

After setup, MailOverTel runs in the background automatically.

Users can then interact with the system directly from the Telegram mobile app.

---

## 5) Understanding The `.env` File

MailOverTel uses a `.env` file to securely store private credentials separately from source code.

The generated `.env` file looks like this:

```env
TELEGRAM_TOKEN=

EMAIL=

APP_PASSWORD=

SENDER_NAME=
```

---

### 🔹 TELEGRAM_TOKEN

Your Telegram bot token.

To get one:

1. Open Telegram
2. Search:
   ```text
   @BotFather
   ```
3. Type:
   ```text
   /newbot
   ```
4. Follow instructions
5. Copy generated token

Paste it into:

```env
TELEGRAM_TOKEN=your_token_here
```

---

### 🔹 EMAIL

The Gmail address MailOverTel will use to send emails.

Example:

```env
EMAIL=example@gmail.com
```

---

### 🔹 APP_PASSWORD

Google blocks normal Gmail passwords for automated systems.

Instead, create a Gmail App Password.

Steps:

1. Enable 2-Step Verification on your Google Account
2. Visit:
   https://myaccount.google.com/apppasswords
3. Generate App Password
4. Paste it into:

```env
APP_PASSWORD=your_generated_password
```

---

### 🔹 SENDER_NAME

Controls how recipients see your name inside their inbox.

Example:

```env
SENDER_NAME=Saayan Chowdhury
```

Recipients will see:

```text
Saayan Chowdhury <yourmail@gmail.com>
```

instead of just the raw Gmail address.

---

## 6) How MailOverTel Works

```text
Telegram Message
        ↓
MailOverTel Backend
        ↓
Ollama (Local LLM)
        ↓
Email Structuring
        ↓
Gmail SMTP
        ↓
Recipient Inbox
```

---

## 7) Understanding The Files

### 🔹 bot.py

The core backend of MailOverTel.

Handles:
* Telegram communication
* AI email generation
* Recipient extraction
* Gmail SMTP communication

---

### 🔹 setup.bat

The one-click setup and deployment file.

Handles:
* Dependency checks
* Python package installation
* AI model setup
* Docker deployment
* Automatic backend startup

---

### 🔹 Dockerfile

Defines the isolated Docker environment MailOverTel runs inside.

Helps maintain:
* cleaner deployments
* dependency isolation
* improved stability

---

### 🔹 docker-compose.yml

Automatically manages Docker services used by MailOverTel.

Without this file, users would need to manually run multiple Docker commands.

---

### 🔹 requirements.txt

Contains all required Python libraries used by the project.

Examples:
* Telegram bot library
* Ollama library
* dotenv library

---

## 8) Usage

Once setup is complete:

1. Open Telegram
2. Open your bot chat
3. Send natural language instructions

Example:

```text
Send an email to xyz@gmail.com telling them to submit the report before 8 PM.
```

MailOverTel automatically:
* generates the email
* structures it properly
* sends it autonomously

---

## 9) Future Plans

### Planned upgrades for MailOverTel include:

|                                                     |
|-----------------------------------------------------|
| Full cloud deployment |
| Voice-to-email pipeline |
| Contact memory and personalization |
| Scheduled emails |
| Multi-agent automation workflows |
| Long-term memory and logging |
| Attachment support |
| Web dashboard |
| Multi-user support |
| Personalized writing styles |

---

## 10) Security Notes

> Never upload your `.env` file to GitHub.

If credentials are accidentally exposed:
* regenerate the Telegram token
* regenerate the Gmail App Password immediately

---

## Conclusion

MailOverTel started as a simple automation experiment and is gradually evolving into a scalable self-hosted AI assistant ecosystem focused on practical real-world automation.

---

## 👨‍💻 Author

Saayan Chowdhury
