/* Gnome-specific code to help with argp integration.
   Written by Tom Tromey <tromey@cygnus.com>.  */

#include <config.h>

#ifndef HAVE_PROGRAM_INVOCATION_SHORT_NAME
char *program_invocation_short_name;
#endif

#ifndef HAVE_PROGRAM_INVOCATION_NAME
char *program_invocation_name;
#endif
