#!/bin/bash


# Define source base and destination base
SRC_BASE="$HOME/.config"
DEST_BASE="$HOME/dotfiles"

# Sync nvim config to submodule directory
NVIM_SRC="$SRC_BASE/nvim"
NVIM_DEST="$DEST_BASE/nvim"

if [ -d "$NVIM_SRC" ]; then
  echo "Syncing $NVIM_SRC to $NVIM_DEST (submodule)"
  rsync -av --delete "$NVIM_SRC/" "$NVIM_DEST/"
  # Commit and push in the submodule
  cd "$NVIM_DEST" || { echo "Failed to enter nvim submodule dir!"; exit 1; }
  git add .
  git commit -m "update nvim config: $(date '+%Y-%m-%d %H:%M:%S')" || echo "No changes to commit in nvim"
  git push origin main  # or the correct branch for nvim repo
  cd "$GIT_REPO_DIR" || exit 1
else
  echo "Warning: $NVIM_SRC does not exist, skipping nvim sync."
fi


CONFIG_BASE_PATH="$HOME/.config"
DOTFILES_BASE_PATH="$HOME/dotfiles"

folders=("rofi" "waybar" "ghostty" "sway" "tmux" "bash")

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

echo "Pushing dotfiles"
git push origin main  # Change branch name if your repo uses a different default branch

echo "Done!"





