# gnome-compiler-flags.m4
#
# serial 3
#

dnl _GNOME_ARG_ENABLE_COMPILE_WARNINGS
dnl
dnl Helper macro of GNOME_COMPILE_WARNINGS(). Pulled in through AC_REQUIRE() so
dnl that it is only expanded once.
dnl
m4_define([_GNOME_ARG_ENABLE_COMPILE_WARNINGS],
[dnl
AC_PROVIDE([$0])[]dnl
AC_ARG_ENABLE([compile-warnings],
              [AS_HELP_STRING([[--enable-compile-warnings=@<:@no/minimum/yes/maximum/error@:>@]],
                              [Turn on compiler warnings])],
              [enable_compile_warnings=$enableval],
              [enable_compile_warnings=yes])[]dnl
])

dnl GNOME_COMPILE_WARNINGS
dnl Turn on many useful compiler warnings and substitute the result into
dnl WARN_CFLAGS for C and WARN_CXXFLAGS for C++.
dnl Use AC_LANG_PUSH to set the language before calling this macro, or it will
dnl use C as the default.
dnl Pass the default value of the --enable-compile-warnings configure option as
dnl the first argument to the macro, defaulting to 'yes'.
dnl Additional warning/error flags can be passed as an optional second argument.
dnl
dnl For example: GNOME_COMPILE_WARNINGS([maximum],[-Werror=some-flag -Wfoobar])
AC_DEFUN([GNOME_COMPILE_WARNINGS],[
    AC_REQUIRE([_GNOME_ARG_ENABLE_COMPILE_WARNINGS])[]dnl

    dnl ******************************
    dnl More compiler warnings
    dnl ******************************

    AS_CASE([$ac_compile],
            [[*'$CFLAGS '*]], [warn_lang=C warn_cc=$CC warn_conftest="conftest.[$]{ac_ext-c}"],
            [[*'$CXXFLAGS '*]], [warn_lang='C++' warn_cc=$CXX warn_conftest="conftest.[$]{ac_ext-cc}"],
            [AC_MSG_ERROR([[current language is neither C nor C++]])])

    warning_flags=
    realsave_CFLAGS="$CFLAGS"

    dnl These are warning flags that aren't marked as fatal.  Can be
    dnl overridden on a per-project basis with -Wno-foo.
    base_warn_flags=" \
        -Wall \
        -Wstrict-prototypes \
        -Wnested-externs \
    "

    dnl These compiler flags typically indicate very broken or suspicious
    dnl code.  Some of them such as implicit-function-declaration are
    dnl just not default because gcc compiles a lot of legacy code.
    dnl We choose to make this set into explicit errors.
    base_error_flags=" \
        -Werror=missing-prototypes \
        -Werror=implicit-function-declaration \
        -Werror=pointer-arith \
        -Werror=init-self \
        -Werror=format-security \
        -Werror=format=2 \
        -Werror=missing-include-dirs \
    "

    dnl Additional warning or error flags provided by the module author to
    dnl allow stricter standards to be imposed on a per-module basis.
    dnl The author can pass -W or -Werror flags here as they see fit.
    additional_flags="m4_default([$2],[])"

    case "$enable_compile_warnings" in
    no)
        warning_flags=
        ;;
    minimum)
        warning_flags="-Wall"
        ;;
    yes|maximum|error)
        warning_flags="$base_warn_flags $base_error_flags $additional_flags"
        ;;
    *)
        AC_MSG_ERROR(Unknown argument '$enable_compile_warnings' to --enable-compile-warnings)
        ;;
    esac

    if test "$enable_compile_warnings" = "error" ; then
        warning_flags="$warning_flags -Werror"
    fi

    dnl Keep in mind that the dummy source must be devoid of any
    dnl problems that might cause diagnostics.
    AC_LANG_CONFTEST([AC_LANG_SOURCE([[
int main(int argc, char** argv) { return (argv != 0) ? argc : 0; }
]])])

    dnl Check whether compile supports the warning options
    for option in $warning_flags; do
      # Test whether the compiler accepts the flag.  Look at standard output,
      # since GCC only shows a warning message if an option is not supported.
      warn_cc_out=`$warn_cc $tested_warning_flags $option -c "$warn_conftest" 2>&1 || echo failed`
      rm -f "conftest.[$]{OBJEXT-o}"

      AS_IF([test "x$warn_cc_out" = x],
            [AS_IF([test "x$tested_warning_flags" = x],
                   [tested_warning_flags=$option],
                   [tested_warning_flags="$tested_warning_flags $option"])],
[cat <<_WARNEOF >&AS_MESSAGE_LOG_FD
$warn_cc: $warn_cc_out
_WARNEOF
])
    done
    unset option
    rm -f "$mm_conftest"

    AC_MSG_CHECKING([what warning flags to pass to the $warn_lang compiler])
    AC_MSG_RESULT([$tested_warning_flags])

    AC_ARG_ENABLE(iso-c,
                  AS_HELP_STRING([--enable-iso-c],
                                 [Try to warn if code is not ISO C ]),,
                  [enable_iso_c=no])

    AC_MSG_CHECKING(what language compliance flags to pass to the C compiler)
    complCFLAGS=
    if test "x$enable_iso_c" != "xno"; then
	if test "x$GCC" = "xyes"; then
	case " $CFLAGS " in
	    *[\ \	]-ansi[\ \	]*) ;;
	    *) complCFLAGS="$complCFLAGS -ansi" ;;
	esac
	case " $CFLAGS " in
	    *[\ \	]-pedantic[\ \	]*) ;;
	    *) complCFLAGS="$complCFLAGS -pedantic" ;;
	esac
	fi
    fi
    AC_MSG_RESULT($complCFLAGS)

dnl TODO use m4 to avoid AS_IF
    AS_IF([test "x$warn_lang" = "xC"],
          [AC_SUBST([WARN_CFLAGS], [$tested_warning_flags $complCFLAGS])],
          [AC_SUBST([WARN_CXXFLAGS], [$tested_warning_flags $complCFLAGS])])
])

dnl For C++, do basically the same thing.

AC_DEFUN([GNOME_CXX_WARNINGS],[
  AC_ARG_ENABLE(cxx-warnings,
                AS_HELP_STRING([--enable-cxx-warnings=@<:@no/minimum/yes@:>@]
                               [Turn on compiler warnings.]),,
                [enable_cxx_warnings="m4_default([$1],[minimum])"])

  AC_MSG_CHECKING(what warning flags to pass to the C++ compiler)
  warnCXXFLAGS=
  if test "x$GXX" != xyes; then
    enable_cxx_warnings=no
  fi
  if test "x$enable_cxx_warnings" != "xno"; then
    if test "x$GXX" = "xyes"; then
      case " $CXXFLAGS " in
      *[\ \	]-Wall[\ \	]*) ;;
      *) warnCXXFLAGS="-Wall -Wno-unused" ;;
      esac

      ## -W is not all that useful.  And it cannot be controlled
      ## with individual -Wno-xxx flags, unlike -Wall
      if test "x$enable_cxx_warnings" = "xyes"; then
	warnCXXFLAGS="$warnCXXFLAGS -Wshadow -Woverloaded-virtual"
      fi
    fi
  fi
  AC_MSG_RESULT($warnCXXFLAGS)

   AC_ARG_ENABLE(iso-cxx,
                 AS_HELP_STRING([--enable-iso-cxx],
                                [Try to warn if code is not ISO C++ ]),,
                 [enable_iso_cxx=no])

   AC_MSG_CHECKING(what language compliance flags to pass to the C++ compiler)
   complCXXFLAGS=
   if test "x$enable_iso_cxx" != "xno"; then
     if test "x$GXX" = "xyes"; then
      case " $CXXFLAGS " in
      *[\ \	]-ansi[\ \	]*) ;;
      *) complCXXFLAGS="$complCXXFLAGS -ansi" ;;
      esac

      case " $CXXFLAGS " in
      *[\ \	]-pedantic[\ \	]*) ;;
      *) complCXXFLAGS="$complCXXFLAGS -pedantic" ;;
      esac
     fi
   fi
  AC_MSG_RESULT($complCXXFLAGS)

  WARN_CXXFLAGS="$CXXFLAGS $warnCXXFLAGS $complCXXFLAGS"
  AC_SUBST(WARN_CXXFLAGS)
])
