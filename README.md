# Project Environment Setup Script

This script automates the setup of a project environment using `tmux` and `docker-compose`. It is designed to simplify the process of running a Docker-based project by automatically setting up a `tmux` session, splitting the window vertically, and running `docker-compose` in one pane.

---

## Features

- Automatically checks if `tmux` is installed and installs it if missing.
- Prompts the user for the project folder name.
- Navigates to the specified project directory.
- Kills any existing `tmux` session with the same name to avoid conflicts.
- Creates a new `tmux` session and splits the window vertically.
- Runs `docker-compose -f docker-compose.dev.yaml up` in the top pane.
- Attaches the user to the `tmux` session.

---

## Example

### Scenario:
You have a project folder named `my_project` located in `/home/reza/djprojects`. You want to set up the environment using this script.

### Steps:
1. Clone the repository (if not already done):
   ```bash
   git clone https://github.com/Rezahosseini65/setup_project.git
   cd setup_project

2. chmod +x setup_project.sh

3. ./setup_project.sh