# gnome-common.m4
# 

dnl GNOME_COMMON_INIT

AC_DEFUN([GNOME_COMMON_INIT],
[
	AC_CACHE_VAL(ac_cv_gnome_aclocal_dir,
	[ac_cv_gnome_aclocal_dir="$GNOME_COMMON_MACROS_DIR"])
	AC_CACHE_VAL(ac_cv_gnome_aclocal_flags,
	[ac_cv_gnome_aclocal_flags="$ACLOCAL_FLAGS"])
	GNOME_ACLOCAL_DIR="$ac_cv_gnome_aclocal_dir"
	GNOME_ACLOCAL_FLAGS="$ac_cv_gnome_aclocal_flags"
	AC_SUBST(GNOME_ACLOCAL_DIR)
	AC_SUBST(GNOME_ACLOCAL_FLAGS)

	ACLOCAL="$ACLOCAL $GNOME_ACLOCAL_FLAGS"

	AM_CONDITIONAL(INSIDE_GNOME_DOCU, false)
])

AC_DEFUN([GNOME_DEBUG_CHECK],
[
	AC_ARG_ENABLE(debug, [  --enable-debug turn on debugging [default=no]], enable_debug="$enableval", enable_debug=no)

	if test x$enable_debug = xyes ; then
	    AC_DEFINE(GNOME_ENABLE_DEBUG,1,
		[Enable additional debugging at the expense of performance and size])
	fi
])

dnl AM_DISABLE_DEPRECATED ()
dnl define DISABLE_DEPRECATED
dnl
AC_DEFUN([AM_DISABLE_DEPRECATED],
[
	if test $USE_MAINTAINER_MODE = yes; then
		DISABLE_DEPRECATED="-DG_DISABLE_DEPRECATED -DGDK_DISABLE_DEPRECATED -DGTK_DISABLE_DEPRECATED -DGNOME_DISABLE_DEPRECATED -DPANGO_DISABLE_DEPRECATED -DBONOBO_DISABLE_DEPRECATED"
	else
		DISABLE_DEPRECATED=""
	fi
	AC_SUBST(DISABLE_DEPRECATED)
])
