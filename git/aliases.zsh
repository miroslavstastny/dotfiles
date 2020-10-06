# list of all oh-my-zsh aliases: https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh

# Check if main exists and use instead of master
function git_main_branch() {
  if [[ -n "$(git branch --list main)" ]]; then
    echo main
  else
    echo master
  fi
}

alias gcm='git checkout $(git_main_branch)'
alias gco='git checkout'

alias gd='git diff'

alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gfo='git fetch origin'
alias gfu='git fetch upstream'

alias glod="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"

alias gmom='git merge origin/$(git_main_branch)'
alias gmum='git merge upstream/$(git_main_branch)'

alias gp='git push'
alias gst='git status'

# use the default stash push on git 2.13 and newer
autoload -Uz is-at-least
is-at-least 2.13 "$(git --version 2>/dev/null | awk '{print $3}')" \
  && alias gsta='git stash push' \
  || alias gsta='git stash save'

alias gstp='git stash pop'

alias grhh='git reset --hard'

alias gup='git pull --rebase'