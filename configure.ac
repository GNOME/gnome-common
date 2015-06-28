AC_PREREQ(2.54)
AC_INIT([gnome-common], [3.14.0],
        [https://bugzilla.gnome.org/enter_bug.cgi?product=gnome-common])

AC_CONFIG_SRCDIR([macros2/gnome-autogen.sh])

AM_INIT_AUTOMAKE([1.9 foreign no-dist-gzip dist-bzip2])

m4_ifdef([AM_SILENT_RULES],[AM_SILENT_RULES([no])])

if test -z "$enable_maintainer_mode"; then
  enable_maintainer_mode=yes
fi
AM_MAINTAINER_MODE([enable])

AC_ARG_WITH([autoconf-archive],
            [AS_HELP_STRING([--with-autoconf-archive],
                            [Enable parallel-installability with autoconf-archive, by disabling installation of its M4 macros])],
            [], [with_autoconf_archive=no])

AM_CONDITIONAL([WITH_AUTOCONF_ARCHIVE],
               [test "x$with_autoconf_archive" != "xno"])

AC_CONFIG_FILES([
Makefile
macros2/Makefile
])

AC_OUTPUT
