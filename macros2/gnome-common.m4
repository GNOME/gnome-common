# gnome-common.m4
# 
# This only for packages that are not in the GNOME CVS tree.

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
])

