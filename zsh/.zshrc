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
znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-history-substring-search
znap source rupa/z
znap source ohmyzsh/ohmyzsh plugins/vi-mode


########################
# Options
########################

autoload -U compinit
compinit -i

HISTSIZE=10000000
SAVEHIST=10000000

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.

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

function zshaddhistory() {
	echo "${1%%$'\n'}|${PWD}   " >> ~/.zsh_history_ext
}

########################
# Aliases
########################

alias vim=nvim
alias cat=bat
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias weather='curl wttr.in'

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Open fzf file with vscode
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute($FZF_EDITOR {})+abort'"

function g86 {
  git branch --merged "${1:-master}" | egrep -v "(^\*|${1:-master})" | xargs git branch -d
}

fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg -n --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg -n --ignore-case --pretty --context 10 '$1' {}"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(~/.local/bin/mise activate zsh)"
eval "$(direnv hook zsh)"

########################
# Customization
########################

if [ -e ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
