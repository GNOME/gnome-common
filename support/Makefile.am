## Process this file with automake to produce Makefile.in.

supportincludedir = $(pkglibdir)/include

if BUILD_GNOME_SUPPORT
INCLUDES = -D_GNU_SOURCE

if CROSS_COMPILING
CC = $(build_CC)
endif

lib_LTLIBRARIES = libgnomesupport.la

supportinclude_HEADERS = gnome-argp.h getopt.h long-options.h argp.h

# it is in _DATA since we don't want `gnomesupport.h' to be part of
# the distributed `.tar.gz' file
supportinclude_DATA = gnomesupport.h

# These are internal headers: they are used only when compiling and
# should not be installed
noinst_HEADERS = argp-fmtstream.h argp-namefrob.h

libgnomesupport_la_SOURCES = long-options.c gnome-argp.c
libgnomesupport_la_LIBADD  = @LTLIBOBJS@
libgnomesupport_la_LDFLAGS = -version-info 0:0:0

noinst_PROGRAMS = gnomesupport-h

BUILT_SOURCES = gnomesupport.h

gnomesupport.h: gnomesupport-h
	./gnomesupport-h > gnomesupport.h-new && \
	mv gnomesupport.h-new gnomesupport.h

endif

EXTRA_DIST = argp-test.c argp.texi
