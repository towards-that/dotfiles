### ================================
### FAST STARTUP (Powerlevel10k)
### ================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### ================================
### PROMPT (Powerlevel10k)
### ================================
source ~/.powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

### ================================
### ALIASES
### ================================
alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"
alias python="python3"
alias ls="eza --icons=always"

### ================================
### HISTORY (Fish-like behavior)
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
### FISH-LIKE TAB COMPLETION
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
### KEYBINDINGS
### ================================
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

### ================================
### PLUGINS (Fish magic)
### ================================
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### ================================
### FZF (Fuzzy everything)
### ================================
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

export FZF_DEFAULT_COMMAND="fdfind --hidden --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fdfind --type d --hidden --exclude .git"

export FZF_DEFAULT_OPTS="
--color=fg:#c0caf5,bg:#1a1b26,hl:#7aa2f7
--color=fg+:#c0caf5,bg+:#24283b,hl+:#7aa2f7
--color=info:#7dcfff,prompt:#7dcfff,pointer:#7dcfff
"

### ================================
### BAT + EZA PREVIEWS
### ================================
export BAT_THEME=tokyonight_night

show_preview='
if [ -d {} ]; then
  eza --tree --color=always {} | head -200
else
  batcat --style=numbers --color=always --line-range :500 {}
fi
'

export FZF_CTRL_T_OPTS="--preview '$show_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

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
### THEFUCK (command fixer)
### ================================
eval "$(thefuck --alias)"

### ================================
### NVM (Node.js)
### ================================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

