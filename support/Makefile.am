## Process this file with automake to produce Makefile.in.

noinst_LIBRARIES=libsupport.a

noinst_HEADERS=getopt.h long-options.h argp-fmtstream.h	\
		argp-namefrob.h argp.h

EXTRA_DIST = argp-test.c

libsupport_a_SOURCES=long-options.c
libsupport_a_LIBADD=@LIBOBJS@
