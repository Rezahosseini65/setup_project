#!/bin/bash

# Check if the script is executable, if not, make it executable
if [[ ! -x "$0" ]]; then
  chmod +x "$0"
  echo "Made the script executable."
fi

# Check if tmux is installed, and install it if missing
if ! command -v tmux &>/dev/null; then
  echo "tmux is not installed. Installing tmux..."
  sudo apt update
  sudo apt install -y tmux
fi

# Base directory where projects are stored
BASE_DIR="/home/reza/djprojects"

# Prompt the user to enter the project folder name
echo "Please enter your project folder name:"
read -r PROJECT_FOLDER

# Combine the base directory with the project folder name
TARGET_DIR="$BASE_DIR/$PROJECT_FOLDER"

# Navigate to the specified project directory
cd "$TARGET_DIR" || { echo "The entered project folder is not valid: $TARGET_DIR"; exit 1; }

# Check if a tmux session with the name 'my_session' already exists, and kill it if it does
if tmux has-session -t my_session 2>/dev/null; then
  echo "An existing tmux session (my_session) was found. Killing it..."
  tmux kill-session -t my_session
fi

# Create a new tmux session and split the window vertically
tmux new-session -d -s my_session
tmux split-window -v  # Vertical split

# Run the docker-compose command in the top pane
tmux send-keys -t my_session:0.0 "docker compose -f docker-compose.dev.yaml up" C-m

# Attach to the tmux session
tmux attach-session -t my_session