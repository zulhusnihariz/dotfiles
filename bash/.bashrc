# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

export PATH="$PATH:/opt/go/bin"
export PATH="$PATH":"/bin/.local/scripts/"
export PATH

if [ -x "$(command -v go)" ] && [ -d "$(go env GOPATH)/bin" ]; then
    PATH="$(go env GOPATH)/bin:$PATH"
fi

source $HOME/.config/bash/.bash_profile

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
