# This program is used to generate gnomesupport.h

BEGIN {
  have_dirent_h = have_ndir_h = have_scandir = have_strcasecmp = 0;
  have_strerror = have_strndup = have_strnlen = have_strtok_r = 0;
  have_sys_dir_h = have_sys_ndir_h = have_vasprintf = have_vsnprintf = 0;
  
  print "/* gnomesupport.h */";
  print "/* This is a generated file.  Please modify `gnomesupport.awk' */";
  print "";
  print "#ifndef GNOMESUPPORT_H";
  print "#define GNOMESUPPORT_H";
  print "";
  print "#ifdef __cplusplus";
  print "extern \"C\" {";
  print "#endif /* __cplusplus */";
  print "";
  print "#include <stddef.h>		/* for size_t */";
}

/^\#define[ \t]+HAVE_DIRENT_H/		{ have_dirent_h = 1 }
/^\#define[ \t]+HAVE_NDIR_H/		{ have_ndir_h = 1 }
/^\#define[ \t]+HAVE_SCANDIR/		{ have_scandir = 1 }
/^\#define[ \t]+HAVE_STRCASECMP/	{ have_strcasecmp = 1 }
/^\#define[ \t]+HAVE_STRERROR/		{ have_strerror = 1 }
/^\#define[ \t]+HAVE_STRNDUP/		{ have_strndup = 1 }
/^\#define[ \t]+HAVE_STRNLEN/		{ have_strnlen = 1 }
/^\#define[ \t]+HAVE_STRTOK_R/		{ have_strtok_r = 1 }
/^\#define[ \t]+HAVE_SYS_DIR_H/		{ have_sys_dir_h = 1 }
/^\#define[ \t]+HAVE_SYS_NDIR_H/	{ have_sys_ndir_h = 1 }
/^\#define[ \t]+HAVE_VASPRINTF/		{ have_vasprintf = 1 }
/^\#define[ \t]+HAVE_VSNPRINTF/		{ have_vsnprintf = 1 }

END {
  if (!have_vasprintf || !have_vsnprintf)
    {
      print ""
      print "#include <stdarg.h>";
    }
  
  if (!have_scandir)
    {
      print ""
      print "#include <sys/types.h>";

      if (have_dirent_h)
	{
	  print "#include <dirent.h>";
	  print "#define NAMLEN(dirent) strlen((dirent)->d_name)";
	}
      else
	{
	  print "#define dirent direct";
	  print "#define NAMLEN(dirent) (dirent)->d_namlen";

	  if (have_sys_ndir_h)
	    print "#include <sys/ndir.h>";
	  if (have_sys_dir_h)
	    print "#include <sys/dir.h>";
	  if (have_ndir_h)
	    print "#include <ndir.h>";
	}

      print ""
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

  if (!have_strerror)
    {
      print ""
      print "/* Return a string describing the meaning of the `errno' code";
      print "   in ERRNUM.  */";
      print "extern char *strerror (int /*errnum*/);";
    }

  if (!have_strcasecmp)
    {
      print ""
      print "/* Compare S1 and S2, ignoring case.  */";
      print "int strcasecmp (const char */*s1*/, const char */*s2*/);"
    }

  if (!have_strndup)
    {
      print ""
      print "/* Return a malloc'd copy of at most N bytes of STRING.  The";
      print "   resultant string is terminated even if no null terminator";
      print "   appears before STRING[N].  */";
      print "char * strndup (const char */*s*/, size_t /*n*/);";
    }

  if (!have_strnlen)
    {
      print ""
      print "/* Find the length of STRING, but scan at most MAXLEN";
      print "   characters.  If no '\\0' terminator is found in that many";
      print "   characters, return MAXLEN.  */";
      print "size_t strnlen (const char */*string*/, size_t /*maxlen*/);";
    }

  if (!have_strtok_r)
    {
      print "";
      print "/* Divide S into tokens separated by characters in DELIM.";
      print "   Information passed between calls are stored in SAVE_PTR.  */";
      print "char * strtok_r (char */*s*/, const char */*delim*/,";
      print "                 char **/*save_ptr*/);";
    }

  if (!have_vasprintf)
    {
      print "";
      print "/* Write formatted output to a string dynamically allocated with";
      print "`malloc'.  Store the address of the string in *PTR.  */";
      print "int vasprintf (char **/*ptr*/, const char */*format*/,";
      print "               va_list /*args*/);";
      print "int asprintf (char **/*ptr*/, const char */*format*/, ...);";
    }

  if (!have_vsnprintf)
    {
      print "";
      print "/* Maximum chars of output to write is MAXLEN.  */";
      print "int vsnprintf (char */*str*/, size_t /*maxlen*/,";
      print "               char */*fmt*/, va_list /*ap*/);";
      print "int snprintf (char */*str*/, size_t /*maxlen*/,";
      print "              char */*fmt*/, ...);";
    }
  
  print ""
  print "#ifdef __cplusplus";
  print "}";
  print "#endif /* __cplusplus */";
  print "";
  print "#endif /* GNOMESUPPORT_H */";
}

    
