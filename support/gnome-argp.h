/* Gnome-specific code to help with argp integration.
   Written by Tom Tromey <tromey@cygnus.com>.  */

#ifndef __GNOME_ARGP_H__
#define __GNOME_ARGP_H__

#ifndef HAVE_STRNDUP
/* Like strdup, but only copy N chars.  */
extern char *strndup (const char *s, size_t n);
#endif

/* Some systems, like Red Hat 4.0, define these but don't declare
   them.  Hopefully it is safe to always declare them here.  */
extern char *program_invocation_short_name;
extern char *program_invocation_name;

#define __mempcpy(To,From,Len) ((char *)memcpy ((To), (From), (Len)) + (Len))

#endif /* __GNOME_ARGP_H__ */
