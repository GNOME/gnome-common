SUBDIRS = macros macros2

EXTRA_DIST = gnome-common.spec

dist-hook:
	for subdir in intl support ; do \
	  mkdir $(distdir)/$$subdir ; \
	  cp -pr $(srcdir)/$$subdir $(distdir) ; \
	done
