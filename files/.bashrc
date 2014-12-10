#!/bin/bash

# P9P
PLAN9=$HOME/plan9
export PLAN9

# Go
GOROOT=$HOME/go
GOOS=linux
#GOARCH=386
GOARCH=amd64
GOBIN=$GOROOT/bin/
GOPATH=$HOME/gopath
export GOROOT GOOS GOARCH GOBIN GOPATH

# Path
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
# Perl
PATH=$HOME/perl5/bin:$PATH
# P9P
PATH=$PATH:$PLAN9/bin
PATH9=$PLAN9/bin:$PATH
PATHU=$PATH
export PATH PATH9 PATHU

# Man
MANPATH=/usr/man:/usr/share/man
MANPATH=$MANPATH:/usr/local/man:/usr/local/share/man
MANPATH=$MANPATH:/usr/share/texmf/man
export MANPATH

# WM (.xinitrc)
WM=`which dwm`
export WM

# Browser (9 web/plumber)
BROWSER=firefox
export BROWSER

# PS1
# PS1="($(hostname))% "
# Prompt is executable
PS1="($(hostname)); "
eval "`hostname`() { cat /dev/null; }"
export PS1

# PAGER
PAGER=less
which most &>/dev/null && PAGER="most"
export PAGER

# Check if running win(1)
if [ "$winid" != "" ]; then
	PAGER=cat
	man() { `which man` $* | nobs; }
	git() { `which git` $* | nobs; }
fi

# Perl
PERL_MB_OPT="--install_base \"/home/mb/perl5\""
export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/mb/perl5"
export PERL_MM_OPT;
PERL5LIB=$HOME/perl5/lib

# convert to mp3
# XXX -> utils/sh/tomp3
tomp3() {
	ext=`echo "$1" | sed 's/.*\.\([^\.]*\)$/\1/'`
	mplayer -vo null -vc dummy -af resample=44100 -ao pcm:nowaveheader:file=/dev/stdout "$1" |\
	lame -h - "${1%$ext}mp3"
}

# cd for p9p
cd() {
	[ "$1" == "" ] && set -- "$HOME"
	builtin cd "$*"; r=$?
	# if running in win(1), update title
	[ "$winid" != "" ] && awd
	return $r
}
# cd followed by a ls
,() { cd $* && ls; }

# randomness is ufn
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

# Git related stuff
alias gst='git status'
alias gsh='git show'
alias ga='git add'
alias gd='git diff'
gl() {
	n=10; [ "$1" != "" ] && n=$1
	git log --oneline | sed ${n}q
}
# git add modified
gam() {
	git status | awk '$2 == "modified:" { print $3 }' | xargs git add
}
# git remove deleted
grd() {
	git status | awk '$2 == "deleted:" { print $3 }' | xargs git rm
}
glast() {
	gl 1 | awk '{ print $1 }'
}
# git show last
gsl() {
	git show `glast`
}
# git show files
gsf() {
	git diff-tree --no-commit-id --name-only -r $*
}

# general aliases
alias ds='du -sh'
alias dh='df -h'
alias lh='/usr/bin/ls -lh'
alias ll='/usr/bin/ls -l'
alias ..='cd ..'
alias ...='cd ../..'
alias grn='/bin/grep -Rn'
alias grin='/bin/grep -Rin'

# look for a perl subroutine definition
gsub() { grep -Rn "^sub $1"; }

gfun() { grep -Rn "^$1("; }

# Awesom
alias ssh-services='ssh -p 25022 admin@awesom.eu'

# ...
ncp() {
	ssh $1 "cat $2" | ssh $3 "cat > $4"
}

# Do erase word with ^W
bind '\C-w:backward-kill-word'
# For ^L in both tmux (TERM=screen) and urxvt (TERM=urxvt-unicode)
TERM=xterm-color

