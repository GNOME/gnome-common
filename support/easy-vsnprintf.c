/* (v)snprintf in terms of __(v)snprintf
 *
 * Useful with Solaris 2.5 libc, which appears to have the `__*' versions
 * of (v)snprintf.
 *
 * This file is in the public domain
 * (in case it matters)
 */

#include <stdarg.h>
#include <stdlib.h>

extern int __vsnprintf (char *, size_t, const char *, va_list);

int
vsnprintf (char *string, size_t maxlen, const char *format, va_list args)
{
  return __vsnprintf (string, maxlen, format, args);
}

int
snprintf (char *string, size_t maxlen, const char *format, ...)
{
  va_list args;
  int retval;
  va_start(args, format);
  retval = vsnprintf (string, maxlen, format, args);
  va_end(args);
  return retval;
}
