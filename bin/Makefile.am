bin_SCRIPTS = gnome-autogen.sh

## We create gnome-autogen.sh here and not from configure because we want
## to get the paths expanded correctly.  Macros like srcdir are given
## the value NONE in configure if the user doesn't specify them (this
## is an autoconf feature, not a bug).
gnome-autogen.sh: gnome-autogen.sh.in Makefile
## Use sed and then mv to avoid problems if the user interrupts.
	sed -e 's#\@datadir\@#$(datadir)#g' \
	      < $(srcdir)/gnome-autogen.sh.in > gnome-autogen.tmp \
	  && mv gnome-autogen.tmp gnome-autogen.sh

EXTRA_DIST = gnome-autogen.sh.in


