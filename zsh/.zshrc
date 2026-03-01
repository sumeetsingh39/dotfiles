# =============================================================================
# .zshrc - EndeavourOS Sway / Catppuccin Mocha Lavender
# =============================================================================

# ==================== Zinit ====================

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light jeffreytse/zsh-vi-mode     # proper vim mode with text objects

# Snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

# Completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# ==================== Prompt ====================

eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

# ==================== Vim mode ====================

# zsh-vi-mode config — set normal mode indicator and keep some emacs bindings
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk       # jk to exit insert mode
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT   # start in insert mode
ZVM_VI_HIGHLIGHT_FOREGROUND=#cdd6f4
ZVM_VI_HIGHLIGHT_BACKGROUND=#45475a

# Restore fzf bindings after zsh-vi-mode loads (it overrides them)
zvm_after_init() {
    eval "$(fzf --zsh)"
    bindkey '^p' history-search-backward
    bindkey '^n' history-search-forward
    bindkey '^r' fzf-history-widget
    bindkey '^f' fzf-file-widget
    bindkey '^[c' fzf-cd-widget
}

# ==================== History ====================

HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ==================== Completion styling ====================

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion:*:descriptions' format '[%d]'
# bat previews for file completions
zstyle ':fzf-tab:complete:cd:*' fzf-preview \
    'eza --color=always --icons $realpath 2>/dev/null || ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview \
    'eza --color=always --icons $realpath 2>/dev/null || ls --color $realpath'
zstyle ':fzf-tab:complete:cat:*' fzf-preview \
    'bat --color=always --style=numbers --line-range=:100 $realpath 2>/dev/null'
zstyle ':fzf-tab:complete:nvim:*' fzf-preview \
    'bat --color=always --style=numbers --line-range=:100 $realpath 2>/dev/null'
zstyle ':fzf-tab:*' switch-group '<' '>'

# ==================== Environment ====================

export EDITOR=nvim
export VISUAL=nvim
export TERMINAL=kitty
export BROWSER=firefox
export MANPAGER='sh -c "col -bx | bat -l man -p"'   # bat as man pager with syntax highlighting
export MANROFFOPT='-c'

# bat theme (Catppuccin Mocha)
export BAT_THEME="Catppuccin Mocha"

# ripgrep config file
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Wayland / cursor
export XCURSOR_THEME=catppuccin-mocha-lavender-cursors
export XCURSOR_SIZE=24
export QT_QPA_PLATFORMTHEME=qt5ct
export QT6_QPA_PLATFORMTHEME=qt6ct
export QT_QPA_PLATFORM=wayland
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export GTK_THEME=catppuccin-mocha-lavender-standard+default

# PATH
export PATH="$HOME/.local/bin:$PATH"

# ==================== Aliases ====================

# --- Package management (yay) ---
alias update='yay -Syu'
alias install='yay -S'
alias remove='sudo pacman -Rns'
alias search='yay -Ss'
alias searchlocal='pacman -Qs'
alias autoremove='sudo pacman -Qdtq | sudo pacman -Rns -'
alias clean='sudo pacman -Sc'
alias pkginfo='pacman -Qi'
alias pkgfiles='pacman -Ql'
alias orphans='pacman -Qdtq'

# --- ls/eza ---
if command -v eza &>/dev/null; then
    alias ls='eza --icons --group-directories-first'
    alias l='eza -l --icons --group-directories-first --git'
    alias la='eza -a --icons --group-directories-first'
    alias lla='eza -la --icons --group-directories-first --git'
    alias lt='eza --tree --icons --level=2'
    alias lta='eza --tree --icons -a --level=2'
elif command -v lsd &>/dev/null; then
    alias ls='lsd --group-dirs first'
    alias l='lsd -l --group-dirs first'
    alias la='lsd -a --group-dirs first'
    alias lla='lsd -la --group-dirs first'
    alias lt='lsd --tree'
else
    alias ls='ls --color=auto --group-directories-first'
    alias l='ls -lh'
    alias la='ls -A'
    alias lla='ls -lAh'
fi

# --- bat (replaces cat) ---
alias cat='bat --paging=never'
alias catp='bat'                                        # bat with paging
alias bh='bat --style=plain --paging=never'             # plain, no line numbers
alias diff='delta'                                      # delta for git diffs (if installed)

# --- ripgrep ---
alias rg='rg --color=always'
alias rgi='rg --ignore-case'                            # case insensitive
alias rgf='rg --files'                                  # list files rg would search
alias rgl='rg -l'                                       # only filenames of matches

# --- Navigation ---
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

# --- Git (with bat/delta for diffs) ---
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gds='git diff --staged'
alias gco='git checkout'
alias gb='git branch'
alias gba='git branch -a'
alias gst='git stash'
alias gstp='git stash pop'
alias gshow='git show | delta'                          # git show with delta highlighting

# --- Editor ---
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# --- Utilities ---
alias c='clear'
alias h='history'
alias grep='rg'                                         # rg as default grep
alias fgrep='rg -F'                                     # fixed strings
alias egrep='rg -e'                                     # regex
alias df='df -h'
alias du='du -h --max-depth=1 | sort -hr'
alias free='free -h'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -Iv'
alias mkdir='mkdir -pv'
alias wget='wget -c'
alias ip='ip --color=auto'

# --- Config quick access ---
alias zshrc='nvim ~/.zshrc'
alias swayconfig='nvim ~/.config/sway/config'
alias waybarconfig='nvim ~/.config/waybar/config'
alias waybarcss='nvim ~/.config/waybar/style.css'
alias kittyconfig='nvim ~/.config/kitty/kitty.conf'
alias dunstconfig='nvim ~/.config/dunst/dunstrc'
alias fuzzelconfig='nvim ~/.config/fuzzel/fuzzel.ini'

# --- Storage ---
alias mstorage='udisksctl mount -b /dev/nvme0n1p4'
alias ustorage='udisksctl unmount -b /dev/nvme0n1p4'
alias storage='cd /run/media/$USER/storage 2>/dev/null || echo "Storage not mounted. Run: mstorage"'

# --- Sway ---
alias reload='swaymsg reload'
alias swaylog='journalctl -b --user -u sway'

# --- Systemd ---
alias sstart='sudo systemctl start'
alias sstop='sudo systemctl stop'
alias srestart='sudo systemctl restart'
alias sstatus='systemctl status'
alias senable='sudo systemctl enable'
alias sdisable='sudo systemctl disable'
alias ustart='systemctl --user start'
alias ustop='systemctl --user stop'
alias urestart='systemctl --user restart'

# --- Development ---
alias serve='python -m http.server'
alias ports='ss -tulanp'
alias myip='curl -s ifconfig.me'

# --- Tmux ---
alias tmux='tmux -u'
alias ta='tmux attach -t'
alias tl='tmux list-sessions'
alias tn='tmux new-session -s'
alias tk='tmux kill-session -t'

# ==================== Functions ====================

# Make directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract any archive
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2|*.tbz2) tar xjf "$1"       ;;
            *.tar.gz|*.tgz)   tar xzf "$1"       ;;
            *.tar.xz|*.txz)   tar xJf "$1"       ;;
            *.tar.zst)        tar --zstd -xf "$1" ;;
            *.tar)            tar xf "$1"         ;;
            *.bz2)            bunzip2 "$1"        ;;
            *.gz)             gunzip "$1"         ;;
            *.xz)             unxz "$1"           ;;
            *.zst)            zstd -d "$1"        ;;
            *.rar)            unrar x "$1"        ;;
            *.zip)            unzip "$1"          ;;
            *.Z)              uncompress "$1"     ;;
            *.7z)             7z x "$1"           ;;
            *)                echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# cd and ls
cl() {
    cd "$1" && ls
}

# fzf file finder — open result in nvim
fv() {
    local file
    file=$(rg --files "${1:-.}" | fzf \
        --preview 'bat --color=always --style=numbers --line-range=:100 {}' \
        --preview-window 'right:55%:wrap') \
    && nvim "$file"
}

# fzf cd — interactive directory jump
fcd() {
    local dir
    dir=$(find "${1:-.}" -type d 2>/dev/null | fzf \
        --preview 'eza --color=always --icons {}' \
        --preview-window 'right:40%') \
    && cd "$dir"
}

# fzf ripgrep — search file contents, open match in nvim
frg() {
    local result
    result=$(rg --color=always --line-number --no-heading "${1:-.}" \
        | fzf --ansi \
              --delimiter ':' \
              --preview 'bat --color=always --style=numbers --highlight-line {2} {1}' \
              --preview-window 'right:55%:+{2}+3/3:wrap') \
    && nvim "$(echo "$result" | cut -d: -f1)" +"$(echo "$result" | cut -d: -f2)"
}

# fzf kill process
fkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf --multi --preview '' | awk '{print $2}')
    [ -n "$pid" ] && echo "$pid" | xargs kill -${1:-9}
}

# fzf history search (better than default)
fh() {
    local cmd
    cmd=$(history | tac | fzf --tac --no-sort \
        --preview 'echo {}' --preview-window 'down:3:wrap') \
    && echo "$cmd" | tr -s ' ' | cut -d' ' -f3- | zsh
}

# Quick note taking
note() {
    echo "$(date '+%Y-%m-%d %H:%M'): $*" >> ~/notes.txt
    echo "Note saved."
}

notes() {
    bat ~/notes.txt 2>/dev/null || echo "No notes yet."
}

# Search notes with fzf
snote() {
    rg "${1:-.}" ~/notes.txt | fzf --preview 'bat --color=always ~/notes.txt'
}

# Find file by name
ff() {
    find . -name "*$1*" 2>/dev/null | fzf \
        --preview 'bat --color=always --style=numbers --line-range=:50 {} 2>/dev/null || ls --color {}'
}

# Show disk usage sorted
dus() {
    du -h --max-depth="${1:-1}" | sort -hr
}

# Copy file to Wayland clipboard
clip() {
    cat "$1" | wl-copy && echo "Copied to clipboard."
}

# Open with xdg
o() {
    xdg-open "$1" &>/dev/null &
}

# Show PATH one per line
path() {
    echo $PATH | tr ':' '\n'
}

# Quick backup
bak() {
    cp "$1" "$1.bak.$(date +%Y%m%d)" && echo "Backed up: $1.bak.$(date +%Y%m%d)"
}

# Preview a file nicely (bat with full styling)
preview() {
    bat --style=full --color=always "$1"
}

# ==================== Shell Integrations ====================

# fzf (restored in zvm_after_init above for vim mode compat)
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='find . -type d 2>/dev/null'
export FZF_DEFAULT_OPTS=" \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
  --color=selected-bg:#45475a \
  --bind 'ctrl-/:toggle-preview' \
  --bind 'ctrl-u:preview-half-page-up' \
  --bind 'ctrl-d:preview-half-page-down' \
  --multi"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:100 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --color=always --icons {}'"

# zoxide
eval "$(zoxide init --cmd cd zsh)"

# ==================== ripgrep config ====================

# Create ripgrep config if it doesn't exist
if [[ ! -f "$HOME/.config/ripgrep/config" ]]; then
    mkdir -p "$HOME/.config/ripgrep"
    cat > "$HOME/.config/ripgrep/config" << 'EOF'
# ripgrep config
--smart-case
--hidden
--glob=!.git/*
--glob=!node_modules/*
--glob=!.next/*
--glob=!dist/*
--glob=!build/*
--colors=line:fg:yellow
--colors=path:fg:blue
--colors=match:fg:red
--colors=match:style:bold
EOF
fi

# ==================== bat config ====================

# Install Catppuccin theme for bat if not already done
if command -v bat &>/dev/null && [[ ! -d "$(bat --config-dir)/themes/Catppuccin Mocha.tmTheme" ]]; then
    mkdir -p "$(bat --config-dir)/themes"
    # Download theme if not present
    if [[ ! -f "$(bat --config-dir)/themes/Catppuccin Mocha.tmTheme" ]]; then
        curl -sL "https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme" \
            -o "$(bat --config-dir)/themes/Catppuccin Mocha.tmTheme" 2>/dev/null && \
            bat cache --build 2>/dev/null
    fi
fi

# ==================== Development Environments ====================

# Android SDK
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Dart CLI completion
[[ -f $HOME/.config/.dart-cli-completion/zsh-config.zsh ]] && \
    source $HOME/.config/.dart-cli-completion/zsh-config.zsh

# console-ninja
export PATH="$HOME/.console-ninja/.bin:$PATH"

# bun completions
[ -s "/home/death/.bun/_bun" ] && source "/home/death/.bun/_bun"
