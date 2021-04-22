# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# added by Anaconda3 4.1.1 installer
# export PATH="/home/niranjan/tools/anaconda3/bin:$PATH"



# added by Anaconda3 installer
export PATH="/anaconda/bin:$PATH"


pdfmerge() { gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile=$@ ; }

# to check continuous mem usage
alias checkmem="free -h | head -n1;  while [[ 1 ]]; do free -h | tail -n2 | head -n1; sleep 1; done"

# Go to a top level directory - parent for many git repos
# run below code to get all repos updated in one go.
alias gitpulls='for dir in `ls -1`; do echo -e "\n\n=========== $dir "; cd $dir; git stash; git pull --rebase; git stash pop; date; cd ..; done'
alias gitstatuses='for dir in `ls -1`; do echo -e "\n\n=========== $dir "; cd $dir; git status; cd ..; done'
alias gitadds='for dir in `ls -1`; do echo -e "\n\n=========== $dir "; cd $dir; git add .; cd ..; done'
alias gitcommits='gitadds; for dir in `ls -1`; do echo -e "\n\n=========== $dir "; cd $dir; git commit -am "dummy message"; cd ..; done'
alias gitpushes='gitcommits; for dir in `ls -1`; do echo -e "\n\n=========== $dir "; cd $dir; git push; cd ..; done'

# Reference : https://askubuntu.com/questions/466198/how-do-i-change-the-color-for-directories-with-ls-in-the-console
LS_COLORS=$LS_COLORS:'di=1;33:' ; # Make directories appear Yellow
export LS_COLORS

# change the command prompt
export PS1='[\[\e[1;32m\]\u($SHLVL) @ \h\[\e[0m\] \[\e[1;46m\]\w\[\e[0m\]]\n\D{%a, %F, %T} \$ '
alias beep="echo -ne '\007'"
alias beep3="for ((i=1; i<=3; i++)); do beep; sleep 1;done"
alias getVol="amixer get \"Master\" | tail -n1 | perl -ne'/(\\d+\\%)/ && print \$1'"
alias setLoud="amixer -q set 'Master' 70%"
alias setSoft="amixer -q set 'Master' 20%"
alias db3="date && beep3"


# Go to a top level directory - parent for many git repos
# run below code to get all repos updated in one go.
alias gitpulls='for dir in `ls -1`; do echo -e "\n\n=========== $dir "; cd $dir; git stash; git pull --rebase; git stash pop; date; cd ..; done'
alias gitstatuss='for dir in `ls -1`; do echo -e "\n\n=========== $dir "; cd $dir; git status; cd ..; done'
alias gitadds='for dir in `ls -1`; do echo -e "\n\n=========== $dir "; cd $dir; git add .; cd ..; done'
alias gitcommits='gitadds; for dir in `ls -1`; do echo -e "\n\n=========== $dir "; cd $dir; git commit -am "dummy message"; cd ..; done'
alias gitpushes='gitcommits; for dir in `ls -1`; do echo -e "\n\n=========== $dir "; cd $dir; git push; cd ..; done'
alias checkmem="free -h | head -n1;  while [[ 1 ]]; do free -h | tail -n2 | head -n1; sleep 1; done"
alias notifySlack="curl -X POST -H 'Content-type: application/json' --data '{\"message\":\"You are needed!\"}' https://hooks.slack.com/workflows-URL"
alias notifySlack3Times="notifySlack; sleep 1; notifySlack; sleep 1; notifySlack"
alias bn3="echo -n \"Completed at : \"; date; beep3; notifySlack3Times"

# https://github.com/mobile-shell/mosh/issues/793
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Wiki on How+to+Set-Up+tmux
alias bb='ssh hostname -t "tmux attach || tmux new"'

decaf() {
    local vpid=$(pgrep vpn)
    if [[ ! $vpid ]]; then
        printf '%s\n' "VPN process not running"
        return 1
    fi
    local cpid=$(pgrep caffeinate)
    if [[ $cpid ]]; then
        caffeinate_pid=$(ps -o args -p "$cpid" | awk 'NR==2 {print $3}')
        if [[ $caffeinate_pid == $vpid ]]; then
            printf '%s\n' "Alreading caffeinating"
            return 0
        fi
    fi

    printf '%s\n' "Caffeinating PID $vpid"
    caffeinate -iw "$vpid" & disown
    return $?
}
# https://www.digitalocean.com/community/tutorials/how-to-use-sshfs-to-mount-remote-file-systems-over-ssh
alias mountld1="sudo diskutil umount force ~/sshfs && sudo sshfs -o allow_other,defer_permissions,IdentityFile=~/.ssh/id_rsa username@hostnameToMount.linkedin.biz:/Remote/AbsPath/toMount ~/sshfs"

