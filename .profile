export PATH=/usr/local/sbin:/usr/local/bin:~/bin:$PATH
export GIT_EXTERNAL_DIFF=git-external-chdiff

## MacPorts
export PATH=$PATH:/opt/local/bin:/opt/local/sbin
export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home/"

export IGNOREEOF=1  # pressing Ctrl+D once will not exit Bash

## Open X11 for graphics (must be running already)
export DISPLAY=:0.0

export HISTIGNORE="&:ls:ls *:[bf]g:exit"
export HISTCONTROL=erasedups	# causes all previous lines matching the current line to be removed from the history list before that line is saved

export PAGER=less;
export EDITOR='/Applications/Aquamacs\ Emacs.app/Contents/MacOS/bin/emacsclient'
export ALTERNATE_EDITOR='emacs'

export IDL_PATH="<IDL_DEFAULT>:~/research:~/research/libraries:~/research/libraries/astrolib:~/research/libraries/db:~/research/libraries/plotting:~/research/libraries/textoidl:~/research/libraries/JHUAPL:~/research/libraries/cmlib:~/research/libraries/buie:~/research/libraries/coyoteprograms"

shopt -s cdspell # Fix mispellings for cd command
shopt -s histappend  # Append to, rather than overwite, to history on disk
PROMPT_COMMAND='history -a' # Write the history to disk whenever you display the prompt

export LC_CTYPE=en_US.UTF-8

## Aliases in seperate file
test -f ~/.bash_aliases && . ~/.bash_aliases

# Bash completion is the best
test -f /opt/local/etc/bash_completion && . /opt/local/etc/bash_completion

# ec2 support
test -f .ec2/.ec2rc && . .ec2/.ec2rc

function parse_git_branch {
  git branch > /dev/null 2>&1 || return 1

  git_status="$(git status 2> /dev/null)"
  branch_pattern="^# On branch ([^${IFS}]*)"
  remote_pattern="# Your branch is (.*) of"
  diverge_pattern="# Your branch and (.*) have diverged"
  if [[ ! ${git_status}} =~ "working directory clean" ]]; then
    state="*"
  fi
##  if [[ ${git_status}} =~ "Changed but not updated" ]]; then
##    state="?"
##  fi
  # add an else if or two here if you want to get more specific
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="↑"
    else
      remote="↓"
    fi
  fi
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="↕"
  fi
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
    echo " (${branch}${state}${remote})"
  fi
}

## export PS1='\h:\W$(__git_ps1 " (%s)")$(parse_git_dirty)\$ '

 export PS1='\h:\W$(parse_git_branch)\$ '

export COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}
