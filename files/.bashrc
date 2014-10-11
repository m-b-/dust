#!/bin/bash

## P9P
PLAN9=$HOME/plan9
export PLAN9

## Go
GOROOT=$HOME/go
GOOS=linux
GOARCH=386
GOBIN=$GOROOT/bin/
GOPATH=$HOME/gopath

export GOROOT GOOS GOARCH GOBIN GOPATH

## Path
# raw
PATH=/bin:/usr/bin:/usr/local/bin
# tex
PATH=/usr/share/texmf/bin/:$PATH
# root
PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin
# go
PATH=$PATH:$GOBIN
# home-made
PATH=$HOME/bin:$PATH
# p9p
PATH=$PATH:$PLAN9/bin
PATH9=$PLAN9/bin:$PATH
PATHU=$PATH

export PATH PATH9 PATHU

## Man
MANPATH=/usr/man:/usr/share/man
MANPATH=$MANPATH:/usr/local/man:/usr/local/share/man
MANPATH=$MANPATH:/usr/share/texmf/man
export MANPATH

## WM (.xinitrc)
WM=`which dwm`
export WM

## PS1
# PS1="($(hostname))% "
# Prompt is valid bash
PS1="($(hostname)); "
eval "`hostname`() { cat /dev/null; }"
export PS1

## PAGER
PAGER=less
which most &>/dev/null && PAGER="most"
export PAGER

## convert to mp3
tomp3() {
	ext=`echo "$1" | sed 's/.*\.\([^\.]*\)$/\1/'`
	mplayer -vo null -vc dummy -af resample=44100 -ao pcm:nowaveheader:file=/dev/stdout "$1" |\
	lame -h - "${1%$ext}mp3"
}

## cd for p9p
cd() {
	[ "$1" == "" ] && set -- "$HOME"
	builtin cd "$*"; r=$?
	# if running in win(1), update title
	[ "$winid" != "" ] && awd
	return $r
}

## cd followed by a ls
cl() { cd $* && ls; }

## random stuff
# random line from a file
randl() {
	# cat |wc to avoid filtering out name
	n=$(echo $RANDOM % `cat $1 | wc -l` + 1 | bc)
	sed -n ${n}p $1
}

# random file from directory
randf() {
	n=$(echo $RANDOM % `ls $1 | wc -l` + 1 | bc)
	ls $1 | sed -n ${n}p
}

# Set random background image from $1 using xv(1) (see .xinitrc)
randbg() {
	cd $1; xv -root `randf $1` -rmode 5 -quit; cd -
}

## aliases
alias ds='du -sh'
alias dh='df -h'
alias lh='/usr/bin/ls -lh'
alias ll='/usr/bin/ls -l'
alias ..='cd ..'
alias ...='cd ../..'

alias gst='git status'
alias ga='git add'
alias gd='git diff'

alias ssh-services='ssh -p 25022 admin@awesom.eu'

#alias vbox='/opt/VirtualBox/VirtualBox'

## Do erase word with ^W
bind '\C-w:backward-kill-word'

# For ^L in both tmux (TERM=screen) and urxvt (TERM=urxvt-unicode)
TERM=xterm-color

