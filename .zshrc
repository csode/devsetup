export PYTHONPATH="/home/compsciwins/.local/share/pipx/venvs/manim/lib/python3.13/site-packages:$PYTHONPATH"
export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:$HOME/go/bin

ZSH_THEME="robbyrussell"
autoload -Uz promptinit
promptinit
prompt walters


source $ZSH/oh-my-zsh.sh
alias v='nvim'
alias vim='nvim'
bindkey -v

alias ff='~/scripts/fzf.sh'
alias gf='~/scripts/fzf_from.sh'
alias gg='~/scripts/git.sh'
alias build='./scripts/build.sh'
alias run='./scripts/run.sh'
alias dev='cd ~/DEV'


alias f='~/scripts/tmux.sh'
alias tt='~/scripts/tmux_sessionizer.sh'
alias cpp='~/scripts/cpp.sh'
alias g='cd $(git ls-tree --name-only HEAD | fzf)'
alias youtube-dl='python3 /usr/local/bin/youtube-dl'
alias cc='gcc'

export TERM=xterm-256color
export PATH="$HOME/.local/bin:$PATH"
tmux_rename_window() {
  tmux rename-window "$1"
}
SESSION_NAME="main"

tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? != 0 ]; then
    tmux new-session -d -s $SESSION_NAME
fi

tmux attach -t $SESSION_NAME

