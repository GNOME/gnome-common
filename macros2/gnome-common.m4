# gnome-common.m4
#
# serial 3
# 

dnl GNOME_COMMON_INIT

AU_DEFUN([GNOME_COMMON_INIT],
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
],
[[$0: This macro is deprecated. You should set put "ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}"
in your top-level Makefile.am, instead, where "m4" is the macro directory set
with AC_CONFIG_MACRO_DIR() in your configure.ac]])

AU_DEFUN([GNOME_DEBUG_CHECK],
[
	AX_CHECK_ENABLE_DEBUG([no],[GNOME_ENABLE_DEBUG])
],
[[$0: This macro is deprecated. You should use AX_CHECK_ENABLE_DEBUG instead and
replace uses of GNOME_ENABLE_DEBUG with ENABLE_DEBUG.
See: http://www.gnu.org/software/autoconf-archive/ax_check_enable_debug.html#ax_check_enable_debug]])

dnl GNOME_MAINTAINER_MODE_DEFINES ()
dnl define DISABLE_DEPRECATED
dnl
AU_DEFUN([GNOME_MAINTAINER_MODE_DEFINES],
[
	AC_REQUIRE([AM_MAINTAINER_MODE])

	DISABLE_DEPRECATED=""
	if test $USE_MAINTAINER_MODE = yes; then
	        DOMAINS="GCONF BONOBO BONOBO_UI GNOME LIBGLADE GNOME_VFS WNCK LIBSOUP"
	        for DOMAIN in $DOMAINS; do
	               DISABLE_DEPRECATED="$DISABLE_DEPRECATED -D${DOMAIN}_DISABLE_DEPRECATED -D${DOMAIN}_DISABLE_SINGLE_INCLUDES"
	        done
	fi

	AC_SUBST(DISABLE_DEPRECATED)
],
[[$0: This macro is deprecated. All of the modules it disables deprecations for
are obsolete. Remove it and all uses of DISABLE_DEPRECATED.]])
