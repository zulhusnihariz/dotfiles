#!/bin/bash

CONFIG_BASE_PATH="$HOME/.config"
DOTFILES_BASE_PATH="$HOME/dotfiles"


folders={"rofi" "waybar" "ghostty" "sway" "tmux" "bash"}

# Define source base and destination base
SRC_BASE="$HOME/.config"
DEST_BASE="$HOME/dotfiles"

GIT_REPO_DIR="$DEST_BASE"

# Change to destination directory
cd "$GIT_REPO_DIR" || { echo "Destination directory not found!"; exit 1; }

# Copy each folder from ~/.config to destination
for folder in "${folders[@]}"; do
  SRC_PATH="$SRC_BASE/$folder"
  DEST_PATH="$DEST_BASE/$folder"

  echo "$SRC_PATH"
  echo "$DEST_PATH"
  
  if [ -d "$SRC_PATH" ]; then
    echo "Copying $SRC_PATH to $DEST_PATH"
    # Remove existing folder in destination to avoid stale files
    rm -rf "$DEST_PATH"
    cp -r "$SRC_PATH" "$DEST_PATH"
  else
    echo "Warning: Source folder $SRC_PATH does not exist, skipping."
  fi
done

# Git operations
echo "Adding changes to git..."
git add .

# Commit with current date/time message
commit_msg="update config backup: $(date '+%Y-%m-%d %H:%M:%S')"
git commit -m "$commit_msg"

echo "Pushing to GitHub..."
git push origin main  # Change branch name if your repo uses a different default branch

echo "Done!"
