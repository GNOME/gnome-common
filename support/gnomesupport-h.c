/* This program is used to generate `gnomesupport.h'.  */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>

/* It emits prototypes of (some of) the functions that have been built
   into libgnomesupport, i.e. functions that are missing on the system.
   It should explain what appears like reverse logic.  
   
   Notes:
   - The generated file SHOULD NOT refer to <config.h>.
   - The generated file SHOULD NOT #define or use (#ifdef/#ifndef &c.) any
     symbols in the HAVE_* namespace.
   - The generated file prefarably should not have any #ifdefs (except for
     the include guard and the C++ guard, which it should have).  */

int main(void)
{
  puts("\
/* gnomesupport.h */
/* This is a generated file.  Please modify `gnomesupport-h.c'.  */

#ifndef GNOMESUPPORT_H
#define GNOMESUPPORT_H

#ifdef __cplusplus
extern \"C\" {
#endif /* __cplusplus */

#include <stddef.h>		/* for size_t */
");
  
#if !defined HAVE_VASPRINTF || !defined HAVE_VSNPRINTF
  puts("\
#include <stdarg.h>
");
#endif

#ifndef HAVE_SCANDIR
  /* FreeBSD apparently needs this before <dirent.h>.
     Anyway, it is a good idea to include <sys/types.h> before including
     any other <sys/...> header.  */
  puts("\
#include <sys/types.h>
");

  /* The following tests and #defines are based on the tests suggested
     for AC_HEADER_DIRENT in the autoconf manual.  */
# if HAVE_DIRENT_H
  puts("\
#include <dirent.h>
#define NAMLEN(dirent) strlen((dirent)->d_name)
");
# else /* not HAVE_DIRENT_H */
  puts("\
#define dirent direct
#define NAMLEN(dirent) (dirent)->d_namlen
");
#  if HAVE_SYS_NDIR_H
  puts("\
#include <sys/ndir.h>
");
#  endif /* HAVE_SYS_NDIR_H */
#  if HAVE_SYS_DIR_H
  puts("\
#include <sys/dir.h>
");
#  endif /* HAVE_SYS_DIR_H */
#  if HAVE_NDIR_H
  puts("\
#include <ndir.h>
");
#  endif /* HAVE_NDIR_H */
# endif /* not HAVE_DIRENT_H */
#endif /* not HAVE_SCANDIR */

  puts("\
#undef PARAMS
#if defined __cplusplus || defined __GNUC__ || __STDC__
# define PARAMS(args) args
#else
# define PARAMS(args) ()
#endif
");
  
#ifndef HAVE_SCANDIR
  puts("\
/* Scan the directory DIR, calling SELECTOR on each directory entry.
   Entries for which SELECTOR returns nonzero are individually malloc'd,
   sorted using qsort with CMP, and collected in a malloc'd array in
   *NAMELIST.  Returns the number of entries selected, or -1 on error.  */
int scandir PARAMS((const char */*dir*/, struct dirent ***/*namelist*/,
		    int (*/*selector*/) PARAMS ((struct dirent *)),
		    int (*/*cmp*/) PARAMS ((const void *, const void *))));

/* Function to compare two `struct dirent's alphabetically.  */
int alphasort PARAMS((const void */*a*/, const void */*b*/));
");
#endif

#ifndef HAVE_STRTOK_R
  puts("\
/* Divide S into tokens separated by characters in DELIM.  Information
   passed between calls are stored in SAVE_PTR.  */
char * strtok_r PARAMS((char */*s*/, const char */*delim*/,
			char **/*save_ptr*/));
");
#endif

#ifndef HAVE_STRCASECMP
  puts("\
/* Compare S1 and S2, ignoring case.  */
int strcasecmp PARAMS((const char */*s1*/, const char */*s2*/));
");
#endif

#ifndef HAVE_STRNDUP
  puts("\
/* Return a malloc'd copy of at most N bytes of STRING.  The
   resultant string is terminated even if no null terminator
   appears before STRING[N].  */
char * strndup PARAMS((const char */*s*/, size_t /*n*/));
");
#endif

#ifndef HAVE_STRNLEN
  puts("\
/* Find the length of STRING, but scan at most MAXLEN characters.
   If no '\\0' terminator is found in that many characters, return MAXLEN.  */
size_t strnlen PARAMS((const char */*string*/, size_t /*maxlen*/));
");
#endif

#ifndef HAVE_VASPRINTF
  puts("\
/* Write formatted output to a string dynamically allocated with `malloc'.
   Store the address of the string in *PTR.  */
int vasprintf PARAMS((char **/*ptr*/, const char */*format*/,
		      va_list /*args*/));
int asprintf PARAMS((char **/*ptr*/, const char */*format*/, ...));
");
#endif

#ifndef HAVE_VSNPRINTF
  puts("\
/* Maximum chars of output to write is MAXLEN.  */
int vsnprintf PARAMS((char */*str*/, size_t /*maxlen*/, char */*fmt*/,
		      va_list /*ap*/));
int snprintf PARAMS((char */*str*/, size_t /*maxlen*/, char */*fmt*/, ...));
");
#endif

  puts("\
#ifdef __cplusplus
}
#endif /* __cplusplus */

#endif /* GNOMESUPPORT_H */
");
  
  return 0;
}
