## Process this file with automake to produce Makefile.in.

supportincludedir = $(pkglibdir)/include

INCLUDES = -D_GNU_SOURCE

lib_LTLIBRARIES = libgnomesupport.la

supportinclude_HEADERS = gnome-argp.h getopt.h long-options.h argp.h error.h

# it is in _DATA since we don't want `gnomesupport.h' to be part of
# the distributed `.tar.gz' file
supportinclude_DATA = gnomesupport.h

# These are internal headers: they are used only when compiling and
# should not be installed
noinst_HEADERS = argp-fmtstream.h argp-namefrob.h gnomesupport-fake.h \
		 findme.h poptint.h

# Hmm... should we move `error.h' here.
include_HEADERS = popt.h

popt_sources = findme.c poptconfig.c poptparse.c popt.c popthelp.c
other_sources = long-options.c gnome-argp.c

libgnomesupport_la_SOURCES = gnomesupport.h $(popt_sources) $(other_sources)
libgnomesupport_la_LIBADD  = @LTLIBOBJS@
libgnomesupport_la_LDFLAGS = -version-info 0:0:0

BUILT_SOURCES = gnomesupport.h

error.c: gnomesupport.h

gnomesupport.h: gnomesupport.awk $(top_builddir)/config.h
	$(AWK) -f $(srcdir)/gnomesupport.awk < $(top_builddir)/config.h > gsh-t
	mv gsh-t gnomesupport.h

EXTRA_DIST = gnomesupport.awk README-gnome 
