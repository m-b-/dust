#!/bin/sh

# Directory where to store sources
SRCDIR=$HOME/src
# Where to store built packages
PKGDIR=$HOME/pkgs
# Configuration files
FILES=$PWD/files

# Packages descriptions are searched in
# $PWD/pkgs; and moved to $PWD/pkgs.done when
# processed.

export SRCDIR PKGDIR FILES

mkdir -p $SRCDIR || exit 1
mkdir -p $PKGDIR || exit 1
mkdir -p "$PWD/pkgs.done" || exit 1

for p in $PWD/pkgs/$1*; do
	unset fetch; unset build; unset mkpkg; unset clean
	source $p
	fetch && build && mkpkg && clean && mv $p "$PWD/pkgs.done/"
done
