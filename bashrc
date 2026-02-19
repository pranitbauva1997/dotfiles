#
# Unified ~/.bashrc (Managed by Dotfiles)
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.welcome_screen ]] && . ~/.welcome_screen

_set_liveuser_PS1() {
    PS1='[\u@\h \W]\$ '
    if [ "$(whoami)" = "liveuser" ] ; then
        local iso_version="$(grep ^VERSION= /usr/lib/endeavouros-release 2>/dev/null | cut -d '=' -f 2)"
        if [ -n "$iso_version" ] ; then
            local prefix="eos-"
            local iso_info="$prefix$iso_version"
            PS1="[\u@$iso_info \W]\$ "
        fi
    fi
}
_set_liveuser_PS1
unset -f _set_liveuser_PS1

ShowInstallerIsoInfo() {
    local file=/usr/lib/endeavouros-release
    if [ -r $file ] ; then
        cat $file
    else
        echo "Sorry, installer ISO info is not available." >&2
    fi
}

alias ls='ls --color=auto'
alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."

[[ "$(whoami)" = "root" ]] && return
[[ -z "$FUNCNEST" ]] && export FUNCNEST=100

## History Search
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# --- NVM & Node ---
if [ -f /usr/share/nvm/init-nvm.sh ]; then
    source /usr/share/nvm/init-nvm.sh
fi

# --- SSH Agent ---
eval "$(ssh-agent -s)" > /dev/null

# --- Paths ---
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
if [ -d "$HOME/go/bin" ]; then
    export PATH="$PATH:$HOME/go/bin"
fi

# --- Global Aliases ---
alias tailnirah="sudo tailscale switch nirah"
alias tailpersonal="sudo tailscale switch personal"
alias tailbuffett="sudo tailscale switch buffettandmunger"
alias taillistenthis_ai="sudo tailscale switch listenthis.ai"
alias fzf-preview="fzf --preview='cat {}'"
alias nfs_mount="sudo mount -t nfs 192.168.0.248:/nfs_share /drives/nfs_tc"
alias nfs_umount="sudo umount /drives/nfs_tc"
alias wg_dashtoon_up='sudo wg-quick up dashtoon'
alias wg_dashtoon_down='sudo wg-quick down dashtoon'

# --- Functions ---
google() {
    gemini -m "gemini-2.5-flash" -p "Search google for <query>$1</query> and summarize results"
}

google-pro() {
    gemini -m "gemini-2.5-pro" -p "Search google for <query>$1</query> and summarize results"
}

smv() {
    if [ $# -lt 2 ]; then
        echo "Usage: smv SOURCE... DEST"
        return 1
    fi
    rsync -vhr --remove-source-files "$@"
}

# --- Images ---
# Wrapper for viu to support Sixel passthrough in tmux
viu() {
    if [ -n "$TMUX" ]; then
        printf "\ePtmux;\e"
        command viu "$@"
        printf "\e\e\\"
    else
        command viu "$@"
    fi
}

# --- Environment ---
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR="nvim"

# --- Secrets (Persona Specific) ---
if [ -f ~/.gemini/.env ]; then
    export $(grep -v '^#' ~/.gemini/.env | xargs)
fi

# --- Auto-Sync Dotfiles (Resilient Hook) ---
# Pull silently in the background if Ironman was offline
(
    if [ -d ~/Codes/dotfiles ]; then
        cd ~/Codes/dotfiles
        # Only pull if we haven't checked in the last 4 hours to keep shell startup fast
        SYNC_MARKER="/tmp/.dotfiles_last_sync_$USER"
        if [ ! -f "$SYNC_MARKER" ] || [ $(find "$SYNC_MARKER" -mmin +240) ]; then
            git pull --quiet &
            touch "$SYNC_MARKER"
        fi
    fi
)
