## Process this file with automake to produce Makefile.in.

supportincludedir = $(includedir)/libgnomesupport

if BUILD_GNOME_SUPPORT

lib_LTLIBRARIES = libgnomesupport.la

supportinclude_HEADERS = gnome-argp.h getopt.h long-options.h argp.h

# These are internal headers: they are used only when compiling and
# should not be installed
noinst_HEADERS = argp-fmtstream.h argp-namefrob.h

libgnomesupport_la_SOURCES = long-options.c gnome-argp.c
libgnomesupport_la_LIBADD  = @LTLIBOBJS@
libgnomesupport_la_LDFLAGS = -version-info 0:0:0

endif

EXTRA_DIST = argp-test.c
