if [ ! -e ~/antigen.zsh  ]; then
  echo "Installing antigen..."
  curl -L git.io/antigen > ~/antigen.zsh
fi

source ~/antigen.zsh

########################
# Packages
########################

antigen use oh-my-zsh
antigen bundle asdf
antigen bundle vi-mode
antigen bundle web-search
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
antigen apply

########################
# Keybindings
########################

# zsh-history-substring-search configuration
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

########################
# Environment
########################

# Set project paths for project jump
# PROJECT_PATHS=(~/code)

########################
# Aliases
########################

alias vim=nvim
alias cat=bat
alias preview="fzf --preview 'bat --color \"always\" {}'"

# Open fzf file with vscode
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"

# Git

git-clean-branches () {
  git branch --merged master | egrep -v "(^\*|master)" | xargs git branch -d
}

########################
# Customization
########################

if [ -e ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
