AC_DEFUN(AM_PATH_GNOME,
[dnl 
dnl Get the cflags and libraries from the gnome-config script
dnl
AC_ARG_WITH(gnome-prefix,[  --with-gnome-prefix=PFX   Prefix where GNOME is installed (optional)],
            gnome_config_prefix="$withval", gnome_config_prefix="")
AC_ARG_WITH(gnome-exec-prefix,[  --with-gnome-exec-prefix=PFX Exec prefix where GNOME is installed (optional)],
            gnome_config_exec_prefix="$withval", gnome_config_exec_prefix="")
AC_ARG_ENABLE(gnometest, [  --disable-gnometest       Do not try to compile and run a test GNOME program],
		    , enable_gnometest=yes)

  if test x$gnome_config_exec_prefix != x ; then
     gnome_config_args="$gnome_config_args --exec-prefix=$gnome_config_exec_prefix"
     if test x${GNOME_CONFIG+set} != xset ; then
        GNOME_CONFIG=$gnome_config_exec_prefix/bin/gnome-config
     fi
  fi
  if test x$gnome_config_prefix != x ; then
     gnome_config_args="$gnome_config_args --prefix=$gnome_config_prefix"
     if test x${GNOME_CONFIG+set} != xset ; then
        GNOME_CONFIG=$gnome_config_prefix/bin/gnome-config
     fi
  fi

  AC_PATH_PROG(GNOME_CONFIG, gnome-config, no)
  min_gnome_version=ifelse([$1], , 1.1.0, $1)

  AC_MSG_CHECKING(for GNOME - version >= $min_gnome_version)
  no_gnome=""
  if test "$GNOME_CONFIG" = "no" ; then
    no_gnome=yes
  else
    GNOME_CFLAGS="`$GNOME_CONFIG $gnome_config_args --cflags gnome`"
    GNOME_LIBS="`$GNOME_CONFIG $gnome_config_args --libs gnome`"
    GNOMEUI_CFLAGS="`$GNOME_CONFIG $gnome_config_args --cflags gnomeui`"
    GNOMEUI_LIBS="`$GNOME_CONFIG $gnome_config_args --libs gnomeui`"

    gnome_config_major_version=`$GNOME_CONFIG $gnome_config_args --version | \
           sed 's/[[^0-9]]*\([[0-9]]*\)\.\([[0-9]]*\)\.\([[0-9]]*\)/\1/'`
    gnome_config_minor_version=`$GNOME_CONFIG $gnome_config_args --version | \
           sed 's/[[^0-9]]*\([[0-9]]*\)\.\([[0-9]]*\)\.\([[0-9]]*\)/\2/'`
    gnome_config_micro_version=`$GNOME_CONFIG $gnome_config_args --version | \
           sed 's/[[^0-9]]*\([[0-9]]*\)\.\([[0-9]]*\)\.\([[0-9]]*\)/\3/'`
    needed_major_version=`echo $min_gnome_version | \
           sed 's/[[^0-9]]*\([[0-9]]*\)\.\([[0-9]]*\)\.\([[0-9]]*\)/\1/'`
    needed_minor_version=`echo $min_gnome_version | \
           sed 's/[[^0-9]]*\([[0-9]]*\)\.\([[0-9]]*\)\.\([[0-9]]*\)/\2/'`
    needed_micro_version=`echo $min_gnome_version | \
           sed 's/[[^0-9]]*\([[0-9]]*\)\.\([[0-9]]*\)\.\([[0-9]]*\)/\3/'`

    if test $gnome_config_major_version -lt $needed_major_version; then
	ifelse([$3], , :, [$3])
	no_gnome=yes
    elif test $gnome_config_major_version = $needed_major_version; then
	if test -n "$needed_minor_version" -a $gnome_config_minor_version -lt $needed_minor_version; then
		ifelse([$3], , :, [$3])
		no_gnome=yes
	elif test -n "$needed_minor_version" -a $gnome_config_minor_version = $needed_minor_version; then
		if test -n "$needed_micro_version" -a $gnome_config_micro_version -lt $needed_micro_version; then
			ifelse([$3], , :, [$3])
			no_gnome=yes
		fi
	fi
    fi
  fi
  AC_SUBST(GNOME_CFLAGS)
  AC_SUBST(GNOME_LIBS)
  AC_SUBST(GNOMEUI_CFLAGS)
  AC_SUBST(GNOMEUI_LIBS)

  if test "x$no_gnome" = x ; then
     AC_MSG_RESULT(yes)
     ifelse([$2], , :, [$2])     
  else
     AC_MSG_RESULT(no)
     if test "$GNOME_CONFIG" = "no" ; then
       echo "*** The gnome-config script installed by GNOME could not be found"
       echo "*** If GNOME was installed in PREFIX, make sure PREFIX/bin is in"
       echo "*** your path, or set the GNOME_CONFIG environment variable to the"
       echo "*** full path to gnome-config."
     else
	:
     fi
     GNOME_CFLAGS=""
     GNOME_LIBS=""
     ifelse([$3], , :, [$3])
  fi

  tmp_gnome_libdir=`$GNOME_CONFIG $gnome_config_args --libdir`
  for module in $4 ""; do
	if test -f $tmp_gnome_libdir/$module'Conf'.sh; then
		tmp_bsnom=`echo $module | tr a-z A-Z`
		eval $tmp_bsnom'_CFLAGS'=\"`$GNOME_CONFIG $gnome_config_args --cflags $module`\"
		eval $tmp_bsnom'_LIBS'=\"`$GNOME_CONFIG $gnome_config_args --libs $module`\"
	elif test "$module" eq zvt; then
	  ZVT_LIBS="`$GNOME_CONFIG $gnome_config_args --libs zvt`"
	  AC_SUBST(ZVT_LIBS)
	elif test "$module" eq gtk; then
	  GTK_CFLAGS="`$GNOME_CONFIG $gnome_config_args --cflags gtk`"
	  GTK_LIBS="`$GNOME_CONFIG $gnome_config_args --libs gtk`"
	  AC_SUBST(GTK_CFLAGS)
	  AC_SUBST(GTK_LIBS)
	elif test "$module" eq "glib"; then
	  GLIB_CFLAGS="`$GNOME_CONFIG $gnome_config_args --cflags glib`"
	  GLIB_LIBS="`$GNOME_CONFIG $gnome_config_args --libs glib`"
	  AC_SUBST(GLIB_CFLAGS)
	  AC_SUBST(GLIB_LIBS)
	elif test "$module" eq "oaf"; then
	  OAF_CFLAGS="`$GNOME_CONFIG $gnome_config_args --cflags oaf`"
	  OAF_LIBS="`$GNOME_CONFIG $gnome_config_args --libs oaf`"
	  AC_SUBST(OAF_CFLAGS)
	  AC_SUBST(OAF_LIBS)
	elif -n "$module"; then
	     echo "*** $module library is not installed"
	     ifelse([$3], , :, [$3])
	fi
  done

  rm -f conf.gnometest
])
