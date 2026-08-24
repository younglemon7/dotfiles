#!/usr/bin/env zsh
# ~/.zshrc

if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi

# ==============================================================================
# 1. INITIALIZATION AND PATH SETUP
# ==============================================================================
alias tshark='tshark --color'

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

_ssh_pick_host () {
  awk '/^Host[ \t]+/ {for (i=2; i<=NF; i++) if ($i !~ /[*!?]/) print $i}' ~/.ssh/config 2>/dev/null \
    | sort -u \
    | fzf \
        --header 'enter: connect | ctrl-y: copy host config' \
        --preview 'awk -v host={} '\''tolower($1)=="host" {show=0; for (i=2; i<=NF; i++) if ($i==host) show=1} show {print}'\'' ~/.ssh/config' \
        --bind 'ctrl-y:execute-silent(awk -v host={} '\''tolower($1)=="host" {show=0; for (i=2; i<=NF; i++) if ($i==host) show=1} show {print}'\'' ~/.ssh/config | pbcopy)+bell'
}

ssh () {
  if (( $# == 0 )); then
    local server
    server=$(_ssh_pick_host)
    if [[ -n $server ]]; then
      print -s -- "ssh $server"
      command ssh -- "$server"
    fi
    return
  fi

  command ssh "$@"
}

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
zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' rehash true

# SSH completion only from ~/.ssh/config
zstyle ':completion:*:(ssh|scp|sftp|rsync):*' hosts \
  ${(f)"$(awk '/^Host[ \t]+/ {for (i=2; i<=NF; i++) if ($i !~ /[*!?]/) print $i}' ~/.ssh/config 2>/dev/null | sort -u)"}

# For ssh completion show only hosts (hide system users)
zstyle ':completion:*:*:ssh:*:*' tag-order hosts
zstyle ':completion:*:*:ssh:*:users' ignored-patterns '*'

# Word style for better text navigation
autoload -Uz select-word-style
select-word-style bash

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# ==============================================================================
# 3. ALIASES
# ==============================================================================

# File listing with eza (modern ls replacement)
if command -v eza &> /dev/null; then
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

alias sshost='bash ~/.ssh/sshost.sh'
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
export PATH="$PATH:$HOME/scripts"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# Editor settings
export EDITOR='nvim'
export VISUAL='nvim'
export KUBE_EDITOR='nvim'

export AICHAT_CONFIG_DIR="$HOME/.config/aichat/"

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
    # Keep Tab on normal completion
    bindkey '^I' expand-or-complete
fi

if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
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
#[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

#compdef opencode
_opencode_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" opencode --get-yargs-completions "${words[@]}"))
  IFS=$si
  if [[ ${#reply} -gt 0 ]]; then
    _describe 'values' reply
  else
    _default
  fi
}
if [[ "'${zsh_eval_context[-1]}" == "loadautofunc" ]]; then
  _opencode_yargs_completions "$@"
else
  compdef _opencode_yargs_completions opencode
fi
###-end-opencode-completions-###
fpath=(~/.zsh/completions $fpath)
autoload -U compinit && compinit

if command -v kubectl &> /dev/null; then
    source <(kubectl completion zsh)
fi

# kimi-code
export PATH="/Users/lemon/.kimi-code/bin:$PATH"
