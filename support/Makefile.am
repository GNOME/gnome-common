## Process this file with automake to produce Makefile.in.

supportexecincludedir = $(pkglibdir)/include

INCLUDES = -D_GNU_SOURCE

lib_LTLIBRARIES = libgnomesupport.la

# it is in _DATA since we don't want `gnomesupport.h' to be part of
# the distributed `.tar.gz' file
supportexecinclude_DATA = gnomesupport.h

# These are internal headers: they are used only when compiling and
# should not be installed
noinst_HEADERS = gnomesupport-fake.h \
		 findme.h poptint.h

# Hmm... should we move `error.h' here.
gnomeincludedir=$(includedir)/gnome-1.0
gnomeinclude_HEADERS = popt-gnome.h

popt_sources = findme.c poptconfig.c poptparse.c popt.c popthelp.c

libgnomesupport_la_SOURCES = gnomesupport.h $(popt_sources) gnome-argp.c
libgnomesupport_la_LIBADD  = @LTLIBOBJS@
libgnomesupport_la_LDFLAGS = -version-info 0:0:0

BUILT_SOURCES = gnomesupport.h

# error.o is not always built.  In the case when it is built, make
# sure gnomesupport.h is built first.
error.o: gnomesupport.h

gnomesupport.h: gnomesupport.awk $(top_builddir)/config.h
	$(AWK) -f $(srcdir)/gnomesupport.awk < $(top_builddir)/config.h > gsh-t
	mv gsh-t gnomesupport.h

EXTRA_DIST = gnomesupport.awk README-gnome \
	canonicalize.c easy-vsnprintf.c error.c error.h \
	findme.c findme.h getopt.c getopt.h getopt1.c \
	gnome-argp.c gnome-argp.h gnomesupport-fake.h \
	memmove.c mkstemp.c popt-gnome.h popt.c poptconfig.c \
	popthelp.c poptint.h poptparse.c scandir.c strcasecmp.c \
	strerror.c strndup.c strnlen.c strtod.c strtok_r.c strtol.c \
	strtoul.c vasprintf.c vsnprintf.c
