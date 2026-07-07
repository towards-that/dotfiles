# Enable emacs-mode in Zsh
bindkey -e


### ================================
### FAST STARTUP (Powerlevel10k)
### ================================
if [[ -n "$TMUX" ]]; then
  # Silence instant prompt completely inside tmux to stop layout glitches
elif [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### ================================
### theme (Powerlevel10k)
### ================================
source ~/.powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

### ================================
### ALIASES
### ================================
alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"
alias python="python3"
alias tmux="tmux -u"

### ================================
### HISTORY 
### ================================
HISTFILE=$HOME/.zhistory
HISTSIZE=10000
SAVEHIST=10000

setopt share_history
setopt hist_ignore_dups
setopt hist_expire_dups_first
setopt hist_verify
setopt inc_append_history

### ================================
### TAB COMPLETION
### ================================

# Enable completion system
autoload -Uz compinit
compinit

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Menu-style completion (like fish)
zstyle ':completion:*' menu select

# Show descriptions
zstyle ':completion:*' format '%F{cyan}%d%f'

# Group results
zstyle ':completion:*' group-name ''

# Smarter matching (substring + partial)
zstyle ':completion:*' completer _extensions _complete _approximate

# Tab cycles forward, Shift-Tab cycles backward
bindkey '^I' complete-word
bindkey '^[[Z' reverse-menu-complete


### ================================
### KEYBINDINGS (Fish-like Up/Down)
### ================================
# Load the substring search widgets
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Bind Up Arrow
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[OA' up-line-or-beginning-search

# Bind Down Arrow
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search
### ================================
### PLUGINS 
### ================================
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### ================================
### FZF (Fuzzy everything)
### ================================
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

# 1. Defaults (Ctrl+T stays local, Alt+C for local directories)
export FZF_DEFAULT_COMMAND="fdfind --hidden --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fdfind --type d --hidden --exclude .git"

export FZF_DEFAULT_OPTS="
--color=fg:#c0caf5,bg:#1a1b26,hl:#7aa2f7
--color=fg+:#c0caf5,bg+:#24283b,hl+:#7aa2f7
--color=info:#7dcfff,prompt:#7dcfff,pointer:#7dcfff
--preview 'batcat --color=always {} 2>/dev/null || file {}'
--preview-window=right:60%:hidden
--bind '?:toggle-preview'
"

# 2. Custom Shortcut: Ctrl + H (Search everything from HOME directory)
fzf-home-search-widget() {
  local selected=$(fdfind --hidden --exclude .git . $HOME | fzf +m)
  if [[ -n "$selected" ]]; then
    LBUFFER="${LBUFFER}${selected}"
  fi
  zle reset-prompt
}
zle -N fzf-home-search-widget
bindkey '^[u' fzf-home-search-widget

# 3. Custom Shortcut: Ctrl + Y (Search everything from SYSTEM ROOT)
fzf-root-search-widget() {
  local selected=$(fdfind --hidden --exclude .git . / | fzf +m)
  if [[ -n "$selected" ]]; then
    LBUFFER="${LBUFFER}${selected}"
  fi
  zle reset-prompt
}
zle -N fzf-root-search-widget
bindkey '^[y' fzf-root-search-widget

### ================================
### ZOXIDE (Smart cd like fish)
### ================================
eval "$(zoxide init zsh)"
alias c="z"

### ================================
### YAZI (Terminal file manager)
### ================================
export EDITOR="nvim"

y() {
  local tmp="$(mktemp -t yazi-cwd.XXXXXX)"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat "$tmp")" && [ -n "$cwd" ]; then
    cd "$cwd"
  fi
  rm -f "$tmp"
}


### ================================
### NVM (Node.js)
### ================================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

alias bat="batcat"
export PATH=$PATH:$HOME/go/bin


alias ls='ls --color=auto -F'
alias ll='ls -lA'
alias la='ls -A'

# Added by Antigravity CLI installer
export PATH="/home/pavan/.local/bin:$PATH"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

export PATH="/usr/sbin:/sbin:$PATH"

# Fix Ctrl+Left and Ctrl+Right to move word-by-word
# bindkey '^[[1;5D' backward-word
# bindkey '^[[1;5C' forward-word


# Ensure beam cursor on initial prompt startup
# echo -ne '\e[6 q'

### ================================
### TERMINAL CURSOR RESET HOOK
### ================================
# Force a vertical beam cursor every single time the Zsh prompt redraws
function precmd() {
  echo -ne '\e[6 q'
}
