#ifndef GNOMESUPPORT_FAKE_H_
#define GNOMESUPPORT_FAKE_H_

#if HAVE_CONFIG_H
# include <config.h>
#endif

#ifdef NEED_GNOMESUPPORT_H
#include <gnomesupport.h>
#endif

#include <gnome-argp.h>

/* Override some of config.h.
   Gnomesupport provides the replacements for these, so you actually
   HAVE_ them.  */

#ifndef HAVE_STRERROR
# define HAVE_STRERROR 1
#endif

#ifndef HAVE_PROGRAM_INVOCATION_NAME
# define HAVE_PROGRAM_INVOCATION_NAME 1
#endif

#endif /* GNOMESUPPORT_FAKE_H_ */
