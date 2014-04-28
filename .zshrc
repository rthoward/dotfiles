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

source $ZSH/oh-my-zsh.sh
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
