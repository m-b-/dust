Add a thin layer of dust to your OS. Tested
on Slackware, but should be portable to others
Unixes.

= Packages
The pkgs.sh script load every pkgs/*. Each of them
define a few functions which are execute in order:

- deps  : check for depencies
- fetch : fetch sources
- build : build program from sources
- mkpkg : create a package
- clean : make clean or similar

Those should all be present, but can be empty. Beware,
not every shell like empty functions; include a comment
or dummy command for safety.

The following variables are exported to the pkgs/* functions:

- SRCDIR : advised directory where source can be placed
- PKGDIR : advised directory where packages can be placed
- FILES  : directory containing configuration files and related

By default, there are respectively

- $HOME/src/
- $HOME/pkgs/
- $PWD/files

See pkgs/urxvt for a full example, pkgs/p9p for a more raw
one. In case, fakerootns can be found there:
https://github.com/Heaumer/utils/blob/master/fakerootns.c
A more classical fakeroot should be usable.

Once done, packages are moved from pkgs/ to pkgs.done/.

= Files
The files.sh script generate and execute a shell script from
files.conf. The latter contains files which should be linked
or copy into a given place in the filesystem.

If making a link (ln -sv) fail, a cp in root is attempted.
No links are made for those files to reduce (..) security risks.

= History
Previous attempt where to simply store raw config files
in a git repository:

	https://github.com/Heaumer/confs

Then, to have a single dirty shell script to do everything:

	https://github.com/Heaumer/cfg

Later, maybe it would be nicer to have/convert current scripts
to Slackbuilds, better integration with eyes.
