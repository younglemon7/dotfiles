#!/usr/bin/env zsh
# ~/.zshrc

# ==============================================================================
# 1. INITIALIZATION AND PATH SETUP
# ==============================================================================

# Ensure UTF-8 locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Homebrew setup
if [[ "$(uname -m)" == "arm64" ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
else
    export PATH="/usr/local/bin:$PATH"
fi

# Initialize Homebrew shell environment
if command -v brew &> /dev/null; then
    eval "$(brew shellenv)"
    
    # Add Homebrew completions to FPATH
    FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
fi

# ==============================================================================
# 2. COMPLETION SYSTEM
# ==============================================================================

# Initialize completion system
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

# Completion configuration
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' rehash true

# Word style for better text navigation
autoload -Uz select-word-style
select-word-style bash

# ==============================================================================
# 3. ALIASES
# ==============================================================================

# File listing with eza (modern ls replacement)
if command -v eza &> /dev/null; then
    alias ls='eza --icons'
    alias l='eza -l --icons --git'
    alias la='eza -la --icons --git'
    alias ll='eza -la --icons --git'
    alias lt='eza -l --tree --icons --git -a'
else
    # Fallback to standard ls
    alias ls='ls --color=auto'
    alias l='ls -lh'
    alias la='ls -lAh'
    alias ll='ls -lah'
fi

# Editor aliases
alias vim='nvim'
alias vi='nvim'

# Dotfiles management
alias dotfiles='git -c status.showUntrackedFiles=no --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'
alias dotfiles-ls='dotfiles ls-tree -r main --name-only'

# ==============================================================================
# 4. ENVIRONMENT VARIABLES
# ==============================================================================

# Custom binaries
export PATH="$PATH:$HOME/.local/bin"

# Editor settings
export EDITOR='nvim'
export VISUAL='nvim'
export KUBE_EDITOR='nvim'

# Kubernetes tools
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export K9S_CONFIG_DIR="$HOME/.config/k9s/"

# Python/Pipx
if command -v register-python-argcomplete &> /dev/null; then
    eval "$(register-python-argcomplete pipx)"
fi

# ==============================================================================
# 5. KEY BINDINGS
# ==============================================================================

# Use emacs keybindings
bindkey -e

# Option + arrow keys for word navigation
bindkey '^[[1;3D' backward-word  # Option + Left Arrow
bindkey '^[[1;3C' forward-word   # Option + Right Arrow

# ==============================================================================
# 6. SOURCE EXTERNAL CONFIGURATIONS
# ==============================================================================

# Local scripts
[[ -f ~/scripts/kubeconfig_zsh ]] && source ~/scripts/kubeconfig_zsh

# Zsh plugins (check existence before sourcing)
if command -v fzf &> /dev/null; then
    source <(fzf --zsh)
fi

if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

if command -v kubectl &> /dev/null; then
    source <(kubectl completion zsh)
fi

# Syntax highlighting (must be sourced last)
if [[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Auto-suggestions
if [[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    
    # Configure auto-suggestions
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#8a8a8a"
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
fi

# ==============================================================================
# 7. COMPLETION SETUP (MUST BE AFTER SOURCING)
# ==============================================================================

# Set up dotfiles completion if git completion is available
if type _git &> /dev/null; then
    compdef dotfiles=git
fi

# ==============================================================================
# 8. UTILITY FUNCTIONS
# ==============================================================================

# Reload zsh configuration
reload() {
    echo "Reloading ~/.zshrc..."
    source ~/.zshrc
}

# Quick edit for zsh configuration
zedit() {
    ${EDITOR:-vim} ~/.zshrc
}

# ==============================================================================
# 9. FINAL SETUP
# ==============================================================================

# Load local overrides if they exist
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

