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

# fzf directories and cd into it
fdd() {
  cd ~
  local dir
  dir=$(find_dir "$@") && cd "$dir"
}

# fzf directories and open it with vscode
fdc() {
  cd ~/Documents
  local dir
  dir=$(find_dir "$@") && code "$dir"
}

# fzf cli history
fch() {
  print -z "$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')"
}

bind '"\C-f":"tmux-sessionizer\n"'

# source ~/.nvm/nvm.sh
alias python=/usr/local/bin/python3
