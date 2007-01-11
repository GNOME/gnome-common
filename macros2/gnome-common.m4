# gnome-common.m4
# 

dnl GNOME_COMMON_INIT

AC_DEFUN([GNOME_COMMON_INIT],
[
  dnl this macro should come after AC_CONFIG_MACRO_DIR
  AC_BEFORE([AC_CONFIG_MACRO_DIR], [$0])

  dnl ensure that when the Automake generated makefile calls aclocal,
  dnl it honours the $ACLOCAL_FLAGS environment variable
  ACLOCAL_AMFLAGS="\${ACLOCAL_FLAGS}"
  if test -n "$ac_macro_dir"; then
    ACLOCAL_AMFLAGS="-I $ac_macro_dir $ACLOCAL_AMFLAGS"
  fi

  AC_SUBST([ACLOCAL_AMFLAGS])
])

AC_DEFUN([GNOME_DEBUG_CHECK],
[
	AC_ARG_ENABLE([debug],
                      AC_HELP_STRING([--enable-debug],
                                     [turn on debugging]),,
                      [enable_debug=no])

	if test x$enable_debug = xyes ; then
	    AC_DEFINE(GNOME_ENABLE_DEBUG, 1,
		[Enable additional debugging at the expense of performance and size])
	fi
])

dnl GNOME_MAINTAINER_MODE_DEFINES ()
dnl define DISABLE_DEPRECATED
dnl
AC_DEFUN([GNOME_MAINTAINER_MODE_DEFINES],
[
	AC_REQUIRE([AM_MAINTAINER_MODE])

	if test $USE_MAINTAINER_MODE = yes; then
		DISABLE_DEPRECATED="-DG_DISABLE_DEPRECATED -DGDK_DISABLE_DEPRECATED -DGDK_PIXBUF_DISABLE_DEPRECATED -DPANGO_DISABLE_DEPRECATED -DGTK_DISABLE_DEPRECATED -DGCONF_DISABLE_DEPRECATED -DBONOBO_DISABLE_DEPRECATED -DBONOBO_UI_DISABLE_DEPRECATED -DGNOME_VFS_DISABLE_DEPRECATED -DGNOME_DISABLE_DEPRECATED -DLIBGLADE_DISABLE_DEPRECATED"
	else
		DISABLE_DEPRECATED=""
	fi
	AC_SUBST(DISABLE_DEPRECATED)
])
