/* Wrapper to implement ANSI C's memmove using BSD's bcopy. */
/* This function is in the public domain.  --Per Bothner. */

#ifdef __STDC__
#include <stddef.h>
#else
#define size_t unsigned long
#endif

void *
memmove (s1, s2, n)
     void *s1;
     const void *s2;
     size_t n;
{
  bcopy (s2, s1, n);
  return s1;
}
