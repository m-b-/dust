#!/bin/sh

FILES=$PWD/files

tmp=`mktemp -d`

awk '
BEGIN {
	FD="'$FILES'"
	TMP="'$tmp'"
}
# command, source, file, dest
function mkcmd(c, s, f, d) {
	printf("%s %s/%s %s/%s", c, s, f, d, f)
}
!/^#/ && ! /^$/ {
	mkcmd("mv", $2, $1, TMP)
	printf("; ")
	mkcmd("ln -sv", FD, $1, $2)
	printf(" || su -c \"")
       	mkcmd("cp", FD, $1, $2)
	print "\""
}' files.conf > $tmp/script

cat $tmp/script
echo 'Is this ok? (^C to abort)'
read
sh $tmp/script
echo 'Please, check again; then delete manually' $tmp
