/* Gnome-specific code to help with argp integration.
   Written by Tom Tromey <tromey@cygnus.com>.  */

#ifndef __GNOME_ARGP_H__
#define __GNOME_ARGP_H__

#ifndef HAVE_STRNDUP
/* Like strdup, but only copy N chars.  */
extern char *strndup (const char *s, size_t n);
#endif

#ifndef HAVE_PROGRAM_INVOCATION_SHORT_NAME
extern char *program_invocation_short_name;
#endif

#ifndef HAVE_PROGRAM_INVOCATION_NAME
extern char *program_invocation_name;
#endif

#endif /* __GNOME_ARGP_H__ */
