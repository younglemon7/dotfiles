eval "$(brew shellenv)"
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi
eval "$(brew shellenv)"
autoload -U select-word-style
select-word-style bash
LANG=en_US.utf-8
LC_ALL=en_US.utf-8

alias l="eza -l --icons --git"
alias la="eza -l --icons --git -a"
alias ll="eza -l --icons --git -a"
alias lt="eza -l --tree --icons --git -a"
alias ls="eza -l --icons"
alias vim="nvim"
alias dotfiles='git -c status.showUntrackedFiles=no --git-dir=$HOME/.dotfiles --work-tree=$HOME'

bindkey '^[[1;3D' backward-word # Option + Left Arrow
bindkey '^[[1;3C' forward-word  # Option + Right Arrow

export PATH="$PATH:/Users/lemon/.local/bin"
export PATH="/opt/homebrew/bin:$PATH"
export KUBE_EDITOR="nvim"
export EDITOR=/opt/homebrew/bin/nvim
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export K9S_CONFIG_DIR="${HOME}/.config/k9s/"


bindkey -e 
eval "$(register-python-argcomplete pipx)"

source <(fzf --zsh)

eval "$(starship init zsh)"
source <(kubectl completion zsh)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
