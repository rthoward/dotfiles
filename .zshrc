export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

# aliases
alias ls='ls -Gp'
alias ll='ls -lth'
alias lla='ll -a'
alias grep='grep --color=auto'
alias fsizes='du -h --max-depth=1 . | sort -n -r'
alias gits='git status'
alias tmux='tmux -2'
alias tma='tmux attach -d -t'
alias tml='tmux list-sessions'
alias tmnew='tmux new-session'
alias git-tmux='tmux new -s $(basename $(pwd))'

# plugins
plugins=(git)

# base16 colorspace
BASE16_SCHEME="tomorrow"
BASE16_SHELL="$HOME/code/base16-shell/base16-$BASE16_SCHEME.dark.sh"
[[ -s $BASE16_SHELL ]] && . $BASE16_SHELL

source $ZSH/oh-my-zsh.sh
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.rvm/bin:$HOME/.cabal/bin:/usr/texbin"
