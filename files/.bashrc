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
PS1="($(hostname))% "
export PS1

## convert to mp3
tomp3() {
	ext=`echo "$1" | sed 's/.*\.\([^\.]*\)$/\1/'`
	mplayer -vo null -vc dummy -af resample=44100 -ao pcm:nowaveheader:file=/dev/stdout "$1" |\
	lame -h - "${1%$ext}mp3"
}

## cd for p9p
cd() {
	if [ "$1" == "" ]; then
		builtin cd $HOME
	else
		builtin cd "$*"
	fi
	[ "$winid" != "" ] && awd
}

# random line from a file
rl() {
	# cat |wc to avoid filtering out name
	n=$(echo $RANDOM % `cat $1 | wc -l` + 1 | bc)
	sed -n ${n}p $1
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
alias gd='PAGER=most git diff'

#alias vbox='/opt/VirtualBox/VirtualBox'

## Do erase word with ^W
bind '\C-w:backward-kill-word'

