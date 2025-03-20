#!/bin/bash

# بررسی اینکه اسکریپت قابل اجرا باشد
if [[ ! -x "$0" ]]; then
  chmod +x "$0"
  echo "Made the script executable."
fi

# بررسی نصب بودن tmux و نصب آن در صورت نیاز
if ! command -v tmux &>/dev/null; then
  echo "tmux is not installed. Installing tmux..."
  sudo apt update
  sudo apt install -y tmux
fi

# مسیر ثابت
BASE_DIR="/home/reza/djprojects"

# پرسیدن نام پوشه پروژه از کاربر
echo "Please enter your project folder name:"
read -r PROJECT_FOLDER

# ترکیب مسیر ثابت با نام پوشه پروژه
TARGET_DIR="$BASE_DIR/$PROJECT_FOLDER"

# وارد شدن به مسیر مشخص شده
cd "$TARGET_DIR" || { echo "The entered project folder is not valid: $TARGET_DIR"; exit 1; }

# اگر session با نام my_session وجود دارد، آن را حذف کن
if tmux has-session -t my_session 2>/dev/null; then
  echo "An existing tmux session (my_session) was found. Killing it..."
  tmux kill-session -t my_session
fi

# ایجاد session جدید و تقسیم پنجره به دو قسمت عمودی
tmux new-session -d -s my_session
tmux split-window -v  # تقسیم عمودی

# اجرای دستور docker-compose در پنل بالا
tmux send-keys -t my_session:0.0 "docker compose -f docker-compose.dev.yaml up" C-m

# اتصال به session tmux
tmux attach-session -t my_session