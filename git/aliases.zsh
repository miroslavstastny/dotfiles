# list of all oh-my-zsh aliases: https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh

# Check if main exists and use instead of master
function git_main_branch() {
  if [[ -n "$(git branch --list main)" ]]; then
    echo main
  else
    echo master
  fi
}

alias cdgr='cd `git rev-parse --show-toplevel`'
cdf() {
        cd `lerna exec --loglevel silent --scope @fluentui/$1 "pwd"`
}

alias gcm='git checkout $(git_main_branch)'
alias gco='git checkout'

alias gcam='git commit -a -m'

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
alias grum='git rebase upstream/$(git_main_branch)'

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

# go from Levi
alias go=fnGitCheckout

fnGitCheckout() {
  # make sure we're in a git repo
  if [[ $(fnIsGitRepo) != "true" ]] then
    return false
  fi

  # get query from arg 1 or wild card
  if (( $# > 0 )) then
    go_query=$1
  else
    go_query="."
  fi
  
  # create branch array, only allow unique items
  # we'll add branches from HEAD and remotes, meaning possible dupes
  go_branches=()
  typeset -U go_branches

  # this fn is recursive
  # the first arg is always the query
  # the following are a list of branches matching the previous query
  # use args >2 as array of branch options (for recursive narrowing)
  if (( $# > 1 )) then
    set -A go_branches ${@:2}
  else
    # add branches in HEAD and on remotes
    for branch in $(git for-each-ref --shell --format='%(refname)' refs/{heads,remotes}); do

      # turn list of branches into something we can "git checkout"
      #
      # INPUT                           OUTPUT
      # 'refs/heads/master'             master
      # 'refs/remotes/origin/gh-pages'  origin gh-pages
      # 'refs/remotes/foo/feature/foo'  foo feature/bar

                                              # replace:
      branch=${branch//\'}                    #   single quotes
      branch=${branch/refs\/heads\/}          #   "refs/heads/"
      branch=${(S)branch/refs\/remotes\/*\/}  #   "refs/remotes/*/" (S) flag == shortest match
      
      # add scrubbed branch name to array
      go_branches+=($branch)
      
    done;
  fi
  
  # running recursively with no matching branches results in an endless loop
  # if there are no 'other' branches to switch to, notify and exit
  if (( ${#go_branches[@]} == 0 )) then
    echo "No other branches in HEAD or on remotes"
    return false
  fi

  go_counter=1
  go_matches=()
  for go_branch in $go_branches; do
    
    # if branch contains query
    if [[ $go_branch =~ $go_query ]] then;
      # add to array
      go_matches[$go_counter]=$go_branch
    
      # print index & name
      echo "$go_counter: $go_branch"
    
      # increment counter
      go_counter=$((go_counter+1))
    fi
  done;
  
  # 0 matches - rerun with no query, showing all options
  if (( ${#go_matches[@]} == 0 )) then
    fnGitCheckout
    return false
  fi

  # 1 match, save it
  if (( ${#go_matches[@]} == 1 )) then
    go_checkout=$go_matches[1]
  fi

  # >1 match, prompt for input
  if (( ${#go_matches[@]} > 1 )) then
    echo ""
    read "go_input?(query/#): "
    
    # if input, attempt select branch from array by index
    if [[ $go_input != "" ]] then
      go_checkout=$go_matches[$go_input]
    fi

    # if input did not result in a valid branch index
    # rerun with input as query against matches
    if [[ $go_checkout == "" ]] then
      fnGitCheckout $go_input $go_matches
      return false
    fi
  fi

  git checkout ${go_checkout}

  unset go_query
  unset go_branches
  unset go_counter
  unset go_branch
  unset go_matches
  unset go_checkout
  unset go_input
}

fnIsGitRepo() {
  git rev-parse --is-inside-work-tree
}