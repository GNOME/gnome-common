# This program is used to generate gnomesupport.h

# Print prologue
BEGIN {
  print "/* gnomesupport.h */";
  print "/* This is a generated file.  Please modify `gnomesupport.awk' */";
  print "";
  print "#ifndef GNOMESUPPORT_H";
  print "#define GNOMESUPPORT_H";
  print "";
  print "#include <stddef.h>		/* for size_t */";
}

# For each `#define HAVE_FOO 1', set def["HAVE_FOO"] = 1
/^\#define[ \t]/ { def[$2] = 1; }

END {
  if (!def["HAVE_VASPRINTF"] || !def["HAVE_VSNPRINTF"]) {
    print "#include <stdarg.h>";
  }

  if (!def["HAVE_SCANDIR"] || def["NEED_DECLARATION_SCANDIR"]) {
    print "#include <sys/types.h>";

    if (def["HAVE_DIRENT_H"]) {
      print "#include <dirent.h>";
      print "#define NAMLEN(dirent) strlen((dirent)->d_name)";
    } else {
      print "#define dirent direct";
      print "#define NAMLEN(dirent) (dirent)->d_namlen";
      
      if (def["HAVE_SYS_NDIR_H"])
	print "#include <sys/ndir.h>";
      if (def["HAVE_SYS_DIR_H"])
	print "#include <sys/dir.h>";
      if (def["HAVE_NDIR_H"])
	print "#include <ndir.h>";
    }
  }

  print "";
  print "#ifdef __cplusplus";
  print "extern \"C\" {";
  print "#endif /* __cplusplus */";

  if (def["NEED_DECLARATION_GETHOSTNAME"]) {
    print "";
    print "/* Get name of current host.  */";
    print "int gethostname(char */*name*/, int /*namelen*/);";
  }

  if (def["NEED_DECLARATION_SETREUID"]) {
    print "";
    print "/* Set real and effective user ID. */";
    print "int setreuid(uid_t /*ruid*/, uid_t /*euid*/);";
  }

  if (def["NEED_DECLARATION_SETREGID"]) {
    print "";
    print "/* Set real and effective group ID. */";
    print "int setregid(gid_t /*rgid*/, gid_t /*egid*/);";
  }
  
  if (def["NEED_DECLARATION_GETPAGESIZE"]) {
    print "";
    print "/* Get system page size. */";
    print "size_t getpagesize(void);";
  }
  
  if (!def["HAVE_MEMMOVE"]) {
    print "";
    print "/* Copies len bytes from src to dest. */";
    print "void * memmove (void */*dest*/, const void */*src*/, size_t /*len*/);";
  }

  if (!def["HAVE_MKSTEMP"]) {
    print "";
    print "/* Generate a unique temporary file name from TEMPLATE.";
    print "   The last six characters of TEMPLATE must be "XXXXXX";";
    print "   they are replaced with a string that makes the filename";
    print "   unique.  Returns a file descriptor open on the file for";
    print "   reading and writing.  */";
    print "int mkstemp (char */*template*/);";
  }
  
  if (!def["HAVE_SCANDIR"] || def["NEED_DECLARATION_SCANDIR"]) {
    print "";
    print "/* Scan the directory DIR, calling SELECTOR on each directory";
    print "   entry.  Entries for which SELECTOR returns nonzero are";
    print "   individually malloc'd, sorted using qsort with CMP, and";
    print "   collected in a malloc'd array in *NAMELIST.  Returns the";
    print "   number of entries selected, or -1 on error.  */";
    print "int scandir (const char */*dir*/, struct dirent ***/*namelist*/,";
    print "             int (*/*selector*/) (struct dirent *),";
    print "             int (*/*cmp*/) (const void *, const void *));";
    print "";
    print "/* Function to compare two `struct dirent's alphabetically.  */";
    print "int alphasort (const void */*a*/, const void */*b*/);";
  }
  
  if (!def["HAVE_STRERROR"]) {
    print "";
    print "/* Return a string describing the meaning of the `errno' code";
    print "   in ERRNUM.  */";
    print "extern char *strerror (int /*errnum*/);";
  }

  if (!def["HAVE_STRCASECMP"]) {
    print "";
    print "/* Compare S1 and S2, ignoring case.  */";
    print "int strcasecmp (const char */*s1*/, const char */*s2*/);";
  }

  if (!def["HAVE_STRNDUP"]) {
    print "";
    print "/* Return a malloc'd copy of at most N bytes of STRING.  The";
    print "   resultant string is terminated even if no null terminator";
    print "   appears before STRING[N].  */";
    print "char * strndup (const char */*s*/, size_t /*n*/);";
  }

  if (!def["HAVE_STRNLEN"]) {
    print "";
    print "/* Find the length of STRING, but scan at most MAXLEN";
    print "   characters.  If no '\\0' terminator is found in that many";
    print "   characters, return MAXLEN.  */";
    print "size_t strnlen (const char */*string*/, size_t /*maxlen*/);";
  }

  if (!def["HAVE_STRTOK_R"]) {
    print "";
    print "/* Divide S into tokens separated by characters in DELIM.";
    print "   Information passed between calls are stored in SAVE_PTR.  */";
    print "char * strtok_r (char */*s*/, const char */*delim*/,";
    print "                 char **/*save_ptr*/);";
  }

  if (!def["HAVE_STRTOD"]) {
    print "";
    print "/* Convert the initial portion of the string pointed to by";
    print "   nptr to double representation and return the converted value.";
    print "   If endptr is not NULL, a pointer to the character after the";
    print "   last character used in the conversion is stored in the";
    print "   location referenced by endptr. */";
    print "double strtod (const char */*nptr*/, char **/*endptr*/);";
  }

  if (!def["HAVE_STRTOL"]) {
    print "";
    print "/* Convert the initial portion of the string pointed to by";
    print "   nptr to a long integer value according to the given base.";
    print "   If endptr is not NULL, a pointer to the character after the";
    print "   last character used in the conversion is stored in the";
    print "   location referenced by endptr. */";
    print "long int strtol (const char */*nptr*/, char **/*endptr*/, int /*base*/);";
  }

  if (!def["HAVE_STRTOUL"]) {
    print "";
    print "/* Convert the initial portion of the string pointed to by";
    print "   nptr to an unsigned long integer value according to the given base.";
    print "   If endptr is not NULL, a pointer to the character after the";
    print "   last character used in the conversion is stored in the";
    print "   location referenced by endptr. */";
    print "unsigned long int strtoul (const char */*nptr*/, char **/*endptr*/,";
    print "                          int /*base*/);";
  }

  if (!def["HAVE_VASPRINTF"]) {
    print "";
    print "/* Write formatted output to a string dynamically allocated with";
    print "   `malloc'.  Store the address of the string in *PTR.  */";
    print "int vasprintf (char **/*ptr*/, const char */*format*/,";
    print "               va_list /*args*/);";
    print "int asprintf (char **/*ptr*/, const char */*format*/, ...);";
  }

  if (!def["HAVE_VSNPRINTF"]) {
    print "";
    print "/* Maximum chars of output to write is MAXLEN.  */";
    print "int vsnprintf (char */*str*/, size_t /*maxlen*/,";
    print "               char */*fmt*/, va_list /*ap*/);";
    print "int snprintf (char */*str*/, size_t /*maxlen*/,";
    print "              char */*fmt*/, ...);";
  }

  if (!def["HAVE_REALPATH"]) {
    print "";
    print "/* Return the canonical absolute name of file NAME.  A canonical name";
    print "   does not contain any `.', `..' components nor any repeated path";
    print "   separators ('/') or symlinks.  All path components must exist.";
    print "   If the canonical name is PATH_MAX chars or more, returns null with";
    print "   `errno' set to ENAMETOOLONG; if the name fits in fewer than PATH_MAX";
    print "   chars, returns the name in RESOLVED.  If the name cannot be resolved";
    print "   and RESOLVED is non-NULL, it contains the path of the first component";
    print "   that cannot be resolved.  If the path can be resolved, RESOLVED";
    print "   holds the same value as the value returned.  */";
    print "";
    print "char *realpath (char */*path*/, char /*resolved_path*/[]);";
  }

  print "";
  print "#ifdef __cplusplus";
  print "}";
  print "#endif /* __cplusplus */";
  print "";
  print "#endif /* GNOMESUPPORT_H */";
}
