#!/bin/sh

SRCDIR=$HOME/src
PKGDIR=$HOME/pkgs
FILES=$PWD/files

export SRCDIR PKGDIR FILES

mkdir -p $SRCDIR || exit 1
mkdir -p $PKGDIR || exit 1
mkdir -p "$PKGDIR".done || exit 1

for p in $PWD/pkgs/*; do
	unset fetch; unset build; unset mkpkg; unset clean
	source $p
	fetch && build && mkpkg && clean && mv $p "$PKGDIR".done
done
