## Process this file with automake to produce Makefile.in.

supportincludedir = $(pkglibdir)/include

if BUILD_GNOME_SUPPORT
INCLUDES = -D_GNU_SOURCE

lib_LTLIBRARIES = libgnomesupport.la

supportinclude_HEADERS = gnome-argp.h getopt.h long-options.h argp.h error.h

# it is in _DATA since we don't want `gnomesupport.h' to be part of
# the distributed `.tar.gz' file
supportinclude_DATA = gnomesupport.h

# These are internal headers: they are used only when compiling and
# should not be installed
noinst_HEADERS = argp-fmtstream.h argp-namefrob.h gnomesupport-fake.h

# gnomesupport.h is listed here to ensure that it is built
libgnomesupport_la_SOURCES = gnomesupport.h long-options.c gnome-argp.c
libgnomesupport_la_LIBADD  = @LTLIBOBJS@
libgnomesupport_la_LDFLAGS = -version-info 0:0:0

BUILT_SOURCES = gnomesupport.h

error.c: gnomesupport.h

gnomesupport.h: gnomesupport.awk $(top_builddir)/config.h
	$(AWK) -f $(srcdir)/gnomesupport.awk < $(top_builddir)/config.h > gsh-t
	mv gsh-t gnomesupport.h

endif

EXTRA_DIST = argp-test.c argp.texi gnomesupport.awk README-gnome \
	argp-ba.c argp-eexst.c argp-fmtstream.c argp-fmtstream.h \
	argp-fs-xinl.c argp-help.c argp-namefrob.h argp-parse.c \
	argp-pv.c argp-pvh.c argp-test.c argp-xinl.c argp.h \
	easy-vsnprintf.c getopt.c getopt.h getopt1.c gnome-argp.c \
	gnome-argp.h long-options.c long-options.h memmove.c mkstemp.c \
	scandir.c strcasecmp.c strerror.c strndup.c strnlen.c strtod.c \
	strtok_r.c strtol.c strtoul.c vasprintf.c vsnprintf.c error.h \
	gnomesupport-fake.h error.c
