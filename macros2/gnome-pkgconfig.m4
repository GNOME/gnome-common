dnl GNOME_PKGCONFIG_CHECK_VERSION() extracts up to 6 decimal numbers out of given-version
dnl and required-version, using any non-number letters as delimiters. it then
dnl compares each of those 6 numbers in order 1..6 to each other, requirering
dnl all of the 6 given-version numbers to be greater than, or at least equal
dnl to the corresponding number of required-version.
dnl GNOME_PKGCONFIG_CHECK_VERSION(given-version, required-version [, match-action] [, else-action])
AC_DEFUN([GNOME_PKGCONFIG_CHECK_VERSION],[
[eval `echo "$1:0:0:0:0:0:0" | sed -e 's/^[^0-9]*//' -e 's/[^0-9]\+/:/g' \
 -e 's/\([^:]*\):\([^:]*\):\([^:]*\):\([^:]*\):\([^:]*\):\([^:]*\):.*/ac_v1=\1 ac_v2=\2 ac_v3=\3 ac_v4=\4 ac_v5=\5 ac_v6=\6/' \
`]
[eval `echo "$2:0:0:0:0:0:0" | sed -e 's/^[^0-9]*//' -e 's/[^0-9]\+/:/g' \
 -e 's/\([^:]*\):\([^:]*\):\([^:]*\):\([^:]*\):\([^:]*\):\([^:]*\):.*/ac_r1=\1 ac_r2=\2 ac_r3=\3 ac_r4=\4 ac_r5=\5 ac_r6=\6/' \
`]
ac_vm=[`expr \( $ac_v1 \> $ac_r1 \) \| \( \( $ac_v1 \= $ac_r1 \) \& \(          \
              \( $ac_v2 \> $ac_r2 \) \| \( \( $ac_v2 \= $ac_r2 \) \& \(         \
               \( $ac_v3 \> $ac_r3 \) \| \( \( $ac_v3 \= $ac_r3 \) \& \(        \
                \( $ac_v4 \> $ac_r4 \) \| \( \( $ac_v4 \= $ac_r4 \) \& \(       \
                 \( $ac_v5 \> $ac_r5 \) \| \( \( $ac_v5 \= $ac_r5 \) \& \(      \
                  \( $ac_v6 \>= $ac_r6 \)                                       \
                 \) \)  \
                \) \)   \
               \) \)    \
              \) \)     \
             \) \)      `]
case $ac_vm in
[1)]
        [$3]
        ;;
*[)]
        [$4]
        ;;
esac
])

dnl
dnl GNOME_CHECK_PKGCONFIG (script-if-enabled, [failflag])
dnl
AC_DEFUN([GNOME_CHECK_PKGCONFIG],[
	AC_PATH_PROG(PKG_CONFIG, pkg-config)
	have_pkgconfig=no
	if test -x "$PKG_CONFIG" ; then
	    have_pkgconfig=yes
	else
	    PKG_CONFIG=
	fi
	AC_MSG_CHECKING(for pkg-config)
	if test x$have_pkgconfig = xyes ; then
	    pkgconfig_required_version=0.8
	    pkgconfig_version=`pkg-config --version`
	    GNOME_PKGCONFIG_CHECK_VERSION($pkgconfig_version, $pkgconfig_required_version, [have_pkgconfig=yes], [have_pkgconfig=no])
	fi
	if test x$have_pkgconfig = xyes ; then
	    AC_MSG_RESULT(yes)
	else
	    PKG_CONFIG=
	    AC_MSG_RESULT(not found)
 	    if test x$2 = xfail; then
		AC_MSG_ERROR([
*** You need the latest pkg-config (at least $pkgconfig_required_version).
*** Get the latest version of pkg-config from
*** http://www.freedesktop.org/software/pkgconfig.])
	    fi
	fi
	AC_SUBST(PKG_CONFIG)

	AC_PROVIDE([GNOME_REQUIRE_PKGCONFIG])
])

dnl
dnl GNOME_REQUIRE_PKGCONFIG
dnl
AC_DEFUN([GNOME_REQUIRE_PKGCONFIG],[
	GNOME_CHECK_PKGCONFIG([], fail)
])

dnl Check if the C compiler accepts a certain C flag, and if so adds it to
dnl CFLAGS
AC_DEFUN([GNOME_PKGCONFIG_CHECK_CFLAG], [
  AC_REQUIRE([GNOME_REQUIRE_PKGCONFIG])

  AC_MSG_CHECKING(if C compiler accepts $1)
  save_CFLAGS="$CFLAGS"

  dnl make sure we add it only once
  dnl this one doesn't seem to work: *[\ \	]$1[\ \ ]*) ;;
  case " $CFLAGS " in
  *\ $1\ *) echo $ac_n "(already in CFLAGS) ... " ;;
  *\ $1\	*) echo $ac_n "(already in CFLAGS) ... " ;;
  *\	$1\ *) echo $ac_n "(already in CFLAGS) ... " ;;
  *\	$1\	*) echo $ac_n "(already in CFLAGS) ... " ;;
  *) CFLAGS="$CFLAGS $1" ;;
  esac

  AC_TRY_COMPILE([#include <stdio.h>], [printf("hello");],
	         [ AC_MSG_RESULT(yes)],dnl
	         [ CFLAGS="$save_CFLAGS" AC_MSG_RESULT(no) ])
])

dnl add $ACLOCAL_FLAGS (and optionally more dirs) to the aclocal
dnl commandline, so make can work even if it needs to rerun aclocal
AC_DEFUN([GNOME_PKGCONFIG_ACLOCALFLAGS],
[
  AC_REQUIRE([GNOME_REQUIRE_PKGCONFIG])

  test -n "$ACLOCAL_FLAGS" && ACLOCAL="$ACLOCAL $ACLOCAL_FLAGS"

  for i in "$1"; do
    ACLOCAL="$ACLOCAL -I $i"
  done
])

AC_DEFUN([GNOME_PKGCONFIG_CHECK_OPTIONAL_MODULES],
[
    AC_REQUIRE([GNOME_REQUIRE_PKGCONFIG])

    name=$1
    depvar=$3

    AC_MSG_CHECKING(for libraries)
    pkg_list=""
    for module in $2 ""; do
	if test -n "$module"; then
	    if `echo $module |grep -q ":"`; then
		dnl has version requirement
		pkg_module_name=`echo $module |sed 's/\(.*\):.*/\1/'`
		test_version=`echo $module |sed 's/.*:\(.*\)/\1/'`

		msg=`$PKG_CONFIG $pkg_module_name 2>&1`
		if test -z "$msg"; then
		    dnl module exists
		    pkg_version=`$PKG_CONFIG --modversion $pkg_module_name`
		    GNOME_PKGCONFIG_CHECK_VERSION($pkg_version, $test_version,
			dnl has the right version
			echo $ac_n "$pkg_module_name "
			pkg_list="$pkg_list $pkg_module_name"
		    ,
			AC_MSG_RESULT([($pkg_module_name)])
			if test x$4 = xfail ; then
				AC_MSG_ERROR([An old version of $pkg_module_name (version $pkg_version) was found. You need at least version $test_version])
			else
				AC_MSG_WARN([An old version of $pkg_module_name (version $pkg_version) was found. You need at least version $test_version])
			fi
		    )
		else
		    dnl doesn't exist
		    AC_MSG_RESULT([($pkg_module_name)])
		    if test x$4 = xfail ; then
			AC_MSG_ERROR([$msg])
		    else
			AC_MSG_WARN([$msg])
		    fi
		fi
	    else
		msg=`$PKG_CONFIG $module 2>&1`
		if test -z "$msg"; then
		    echo $ac_n "$module "
		    pkg_list="$pkg_list $module"
		else
		    AC_MSG_RESULT([($module)])
		    if test x$4 = xfail ; then
			AC_MSG_ERROR([$msg])
		    else
			AC_MSG_WARN([$msg])
		    fi
		fi
	    fi
	fi
    done
    AC_MSG_RESULT([])
    if test -n "$pkg_list"; then
	eval $name'_CFLAGS'=\"`$PKG_CONFIG --cflags $pkg_list`\"
	eval $name'_LIBS'=\"`$PKG_CONFIG --libs $pkg_list`\"
	if test -n "$depvar"; then
	    eval $depvar'_DEPENDS'=\"\$$depname'_DEPENDS' $pkg_list\"
	else
	    eval $name'_DEPENDS'=\"$pkg_list\"
	fi
	if test -z "$4" ; then
	    eval 'HAVE_'$name=yes
	fi
	eval 'have_'$name=yes
    else
	eval 'have_'$name=no
    fi
])

AC_DEFUN([GNOME_PKGCONFIG_CHECK_MODULES],
[
	GNOME_PKGCONFIG_CHECK_OPTIONAL_MODULES($1,$2,$3,fail)
])
