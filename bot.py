from telegram import Update
from telegram.ext import (
    Application,
    MessageHandler,
    ContextTypes,
    filters
)

from dotenv import load_dotenv
from email.message import EmailMessage

import smtplib
import ollama
import os
import re


# ==========================
# LOAD ENVIRONMENT VARIABLES
# ==========================

load_dotenv(dotenv_path=".env")

TOKEN = os.getenv("TELEGRAM_TOKEN")
EMAIL = os.getenv("EMAIL")
PASSWORD = os.getenv("APP_PASSWORD")
SENDER_NAME = os.getenv("SENDER_NAME")


# ==========================
# STARTUP CHECKS
# ==========================

if not TOKEN:
    raise Exception(
        "TELEGRAM_TOKEN not found. Check .env"
    )

if not EMAIL:
    raise Exception(
        "EMAIL not found. Check .env"
    )

if not PASSWORD:
    raise Exception(
        "APP_PASSWORD not found. Check .env"
    )


print("Bot Token Loaded ✓")
print("Email Loaded ✓")


# ==========================
# AI EMAIL GENERATOR
# ==========================

def generate_email(user_prompt):

    try:

        client = ollama.Client(
            host='http://host.docker.internal:11434'
        )

        response = client.chat(
            model='gemma4',
            messages=[
                {
                    'role': 'system',
                    'content':
                    '''
You are an intelligent email writing assistant.

Rules:

1. Write emails naturally as if written personally by the sender.

2. Never mention:
- AI
- automation
- generated content
- bots

3. Adapt tone automatically:
- formal for professors/work
- casual for friends
- concise for quick communication

4. Avoid robotic phrasing.

5. Do not invent fake names or signatures.

6. Keep emails human-like and realistic.

7. Strict output format:

Subject: ...

Body:
...
'''
                },

                {
                    'role': 'user',
                    'content': user_prompt
                }
            ]
        )

        return response['message']['content']

    except Exception as e:

        print("Ollama Error:", e)

        return """
Subject: Message

Body:
Please check this automated message.
"""

# ==========================
# SEND MAIL
# ==========================

def send_mail(receiver, ai_content):

    try:

        subject_match = re.search(
            r"Subject:(.*)",
            ai_content
        )

        body_match = re.search(
            r"Body:(.*)",
            ai_content,
            re.DOTALL
        )

        subject = (
            subject_match.group(1).strip()
            if subject_match
            else "No Subject"
        )

        body = (
            body_match.group(1).strip()
            if body_match
            else ai_content
        )

        msg = EmailMessage()

        msg["Subject"] = subject
        msg["From"] = f"{SENDER_NAME} <{EMAIL}>"
        msg["To"] = receiver

        msg.set_content(body)

        server = smtplib.SMTP_SSL(
            "smtp.gmail.com",
            465
        )

        server.login(
            EMAIL,
            PASSWORD
        )

        server.send_message(msg)

        server.quit()

        print("Email Sent ✓")

        return True

    except Exception as e:

        print("Mail Error:", e)

        return False


# ==========================
# TELEGRAM HANDLER
# ==========================

async def handle(
        update: Update,
        context: ContextTypes.DEFAULT_TYPE
):

    try:

        text = update.message.text

        print("Received:", text)

        await update.message.reply_text(
            "Generating mail..."
        )

        email_match = re.search(
            r'[\w\.-]+@[\w\.-]+\.\w+',
            text
        )

        if not email_match:

            await update.message.reply_text(
                "No email address found."
            )

            return

        receiver = email_match.group()

        print("Receiver:", receiver)

        generated_email = generate_email(text)

        print("Generated Email:")
        print(generated_email)

        status = send_mail(
            receiver,
            generated_email
        )

        print("Mail Status:", status)

        if status:

            await update.message.reply_text(
                f"Mail sent to {receiver} ✓"
            )

            print("Telegram confirmation sent")

        else:

            await update.message.reply_text(
                "Failed to send mail."
            )

    except Exception as e:

        print("Handler Error:", e)

        try:

            await update.message.reply_text(
                f"Error: {e}"
            )

        except:
            pass

# ==========================
# START BOT
# ==========================

print("Starting Bot...")

app = (
    Application.builder()
    .token(TOKEN)
    .build()
)

app.add_handler(
    MessageHandler(
        filters.TEXT &
        ~filters.COMMAND,

        handle
    )
)

print("Bot Running ✓")

app.run_polling()