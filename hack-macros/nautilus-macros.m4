dnl
dnl NAUTILUS_VERSION_CANON(version)
dnl                     1
AC_DEFUN(NAUTILUS_VERSION_CANON, [`

	dnl Assumes that there are no more than 999 revisions at a level,
	dnl no more than three levels of revision.
	dnl
	dnl Any more than that, and test starts messing up the numeric
	dnl comparisons because its integers overflow, and there's no
	dnl way to do string comparisons in the shell.  Grr.
	dnl
	dnl Must come up with some way to fix this.

	echo "$1" |
	tr . '\012' |
	sed -e 's/^/000/' -e 's/^.*\(...\)/\1/' |
	tr -d '\012' |
	sed 's/$/000000000/
	     s/^\(.........\).*/\1/'
`])

dnl NAUTILUS_VERSION_INSIST(package, get-version-cmd, operator, want-version-var)
dnl                      1        2                3         4

AC_DEFUN(NAUTILUS_VERSION_INSIST, [
	ez_want_version=[$]$4

	case "$3" in
		">")	ez_operator=-gt ;;
		">=")	ez_operator=-ge ;;
		"<")	ez_operator=-lt ;;
		"<=")	ez_operator=-le ;;
		"=")	ez_operator=-eq ;;
		"!=")	ez_operator=-ne ;;
		*)	AC_ERROR(Unknown operator $3 in configure script) ;;
	esac

	AC_MSG_CHECKING(for $1 $3 [$ez_want_version])

	if ez_installed_version="`$2`"
	then
		AC_MSG_RESULT([$ez_installed_version])
	else
		AC_ERROR($2 failed)
	fi

	if test "NAUTILUS_VERSION_CANON([$ez_installed_version])" "$ez_operator" \
		"NAUTILUS_VERSION_CANON([$ez_want_version])"
	then
		:
		AC_SUBST($4)
	else
		AC_ERROR($1 version [$ez_want_version] is required.)
	fi
])
