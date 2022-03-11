########################
# Package Manager
########################

if [ ! -f ~/.zsh/znap/znap.zsh ]; then
  git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git ~/.zsh/znap
fi

source ~/.zsh/znap/znap.zsh

########################
# Packages
########################

znap prompt sindresorhus/pure
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-history-substring-search
znap source rupa/z
znap source ohmyzsh/ohmyzsh plugins/asdf
znap source ohmyzsh/ohmyzsh plugins/vi-mode


########################
# Options
########################

autoload -U compinit
compinit -i

########################
# Keybindings
########################

VI_MODE_SET_CURSOR=true

# zsh-history-substring-search configuration
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

########################
# Environment
########################

# Set project paths for project jump
# PROJECT_PATHS=(~/code)

export FZF_EDITOR="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

function zshaddhistory() {
	echo "${1%%$'\n'}|${PWD}   " >> ~/.zsh_history_ext
}

########################
# Aliases
########################

alias vim=nvim
alias cat=bat
alias preview="fzf --preview 'bat --color \"always\" {}'"

#export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Open fzf file with vscode
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute($FZF_EDITOR {})+abort'"

git-clean-branches() {
  merge_branch="${1:-main}"
  echo "Purging all branches that have been merged into ${merge_branch}"
  git branch --merged $merge_branch | egrep -v "(^\*|$merge_branch)" | xargs git branch -d
}

fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg -n --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg -n --ignore-case --pretty --context 10 '$1' {}"
}

########################
# Customization
########################

if [ -e ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# . $HOME/.asdf/asdf.sh
# . $HOME/.poetry/env

eval "$(direnv hook zsh)"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"
