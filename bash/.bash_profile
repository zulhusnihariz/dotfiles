# .bash_profile

# include flatpak installed apps
export XDG_DATA_DIRS="$XDG_DATA_DIRS:/var/lib/flatpak/exports/share/applications/"
export QT_QPA_PLATFORMTHEME=qt5ct


HISTSIZE=1000
HISTFILESIZE=2000

# Avoid duplicate history entries and ignore commands starting with space
export HISTCONTROL=ignoredups:erasedups:ignorespace
# Append to history file, don't overwrite it
shopt -s histappend
# Update history file after each command
export PROMPT_COMMAND='history -a; history -c; history -r;'

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_DEFAULT_OPTS="--preview 'bat --style=numbers right:hidden:wrap --color=always {} || cat {}' --bind 'j:down,k:up,ctrl-j:preview-down,ctrl-k:preview-up'"

find_dir(){
  fd --type d --exclude '.*' . "${1:-.}" 2> /dev/null | fzf +m
}

# Assumes find_dir is a function or command available in your environment.
fdd() {
  cd ~ || return
  local dir
  dir=$(find_dir "$@") && cd "$dir" || return
}

# fzf directories and open it with vscode
fdc() {
  cd ~/Documents || return
  local dir
  dir=$(find_dir "$@") && code "$dir"
}

# fzf cli history search and execute selected command
fch() {
  # Get history lines, reverse order (-r), and pass to fzf
  local cmd
  cmd=$(history | tac | fzf +s --tac | sed 's/ *[0-9]* *//')
  read -e -i "$cmd" -p "Command: " input
  echo "Running: $input"
  eval "$input"
}

bind '"\C-f":"tmux-sessionizer\n"'

# source ~/.nvm/nvm.sh
alias python=/usr/local/bin/python3
alias hibernate='systemctl suspend'
alias dsync='bash $HOME/dotfiles/sync.sh'



