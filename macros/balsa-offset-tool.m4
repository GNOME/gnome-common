dnl Set up the Balsa offset tool
dnl BALSA_OFFSET_TOOL( fragment name, file1 file2 file3, [extra defs], [tool home], [tool name] )
dnl    $1 is the make fragment location to look at
dnl    $2 is the list of files to examine for offset inputs and hints
dnl    $3 is the optional list of extra variable settings to pass to the offset tool. You're
dnl          probably interested in overriding CFLAGS here. You're given ${top_srcdir} and 
dnl          ${top_builddir} to work from; don't forget to quote tehm
dnl    $4 is the optional subdirectory of srcdir to find the tool in; defaults to macros
dnl    $5 is the optional filename of the tool (not the infile); defaults to offset-tool.sh
dnl    AC_SUBST's BALSA_OFFSET_MAKERULES       which should be placed in a Makefile somewhere
dnl               BALSA_OFFSET_SRCPATH         which goes from top_builddir to the top srcdir
dnl               BALSA_OFFSET_TOOL_HOME       which records the fourth option
dnl               BALSA_OFFSET_TOOL_NAME       which records the fifth option
dnl               BALSA_OFFSET_TOOL_DEFSFILE   which records the name of the definitions file,
dnl                                            relative to top_builddir
dnl               BALSA_OFFSET_TOOL_DOTS       how to get to top_builddir from where the 
dnl                                            makefragment is
dnl
dnl Issues: 
dnl
dnl        I can't think of a way to make this compatible with cross-compiling. We can build
dnl a proper executable with the correct offsets, but we can't run it. If we had some way of
dnl poking at the binary, we could find the values, but that is hard.
dnl
dnl        You should be able to specify the defs file's name, I'm just too lazy right now.
dnl The current code assumes that the tool-name has a -tool in it to calculate the defs file's
dnl name.
dnl
dnl        All that config.status stuff is a bit complicated.
dnl
dnl        Some dependencies might be missing or not quite right.

dnl serial 1
AC_DEFUN([BALSA_OFFSET_TOOL],[
	AC_MSG_CHECKING([for offset tool Makefile fragment location])
	AC_MSG_RESULT($1)

	AC_MSG_CHECKING([for inputs to offset header])
	AC_MSG_RESULT($2)

	if test x"$4" = x ; then
		BALSA_OFFSET_TOOL_HOME=macros
	else
		BALSA_OFFSET_TOOL_HOME='$4'
	fi

	if test x"$5" = x ; then
		BALSA_OFFSET_TOOL_NAME=offset-tool.sh
	else
		BALSA_OFFSET_TOOL_NAME='$5'
	fi

	if test ! -r ${srcdir}/${BALSA_OFFSET_TOOL_HOME}/${BALSA_OFFSET_TOOL_NAME}.in ; then
		AC_MSG_ERROR([Cannot locate ${srcdir}/${BALSA_OFFSET_TOOL_HOME}/${BALSA_OFFSET_TOOL_NAME}.in])
	fi

	BALSA_OFFSET_TOOL_DEFSFILE=`echo "${BALSA_OFFSET_TOOL_HOME}/${BALSA_OFFSET_TOOL_NAME}" |sed -e 's,-tool,-defs,'`

	ifelse($3,[],[
		define([cat_command],[])
		define([cat_vars],[])
	],[
		define([cat_command],[
		echo creating ${BALSA_OFFSET_TOOL_DEFSFILE}
		#Don't collide with the EOF inside the AC_OUTPUT_COMMANDS that we're in
		cat <<BOTEOF >${BALSA_OFFSET_TOOL_DEFSFILE}
${BALSA_OFFSET_TOOL_EXDEFS}
BOTEOF
])
		define([cat_vars],[
			BALSA_OFFSET_TOOL_EXDEFS='$3'
		])

	])

	dnl cat_command

	changequote(<<,>>)dnl Clobbers my regexes!

	#Make everything relative to the make fragment

	frag_dots=`echo $1 |sed -e 's,\(.*/\)[^/]*,\1,' -e 's,[^/]*/,../,g'`
	frag_basename=`echo $1 |sed -e 's,.*/\([^/]*\),\1,'`
	frag_subdir=`echo $1 |sed -e 's,\(.*/\)[^/]*,\1,'`

	changequote([,])dnl

	#Transform the input names into relative from make fragment to srcdir

	case "${srcdir}" in
	/*)
		infile_prefix=
		;;
	*)
		infile_prefix="${frag_dots}"
		;;
	esac

	new_infiles=
	for ping in $2 ; do 
		new_infiles="${new_infiles} ${infile_prefix}${srcdir}/${ping}"
	done
	new_infiles=`echo ${new_infiles} |sed -e 's,^ ,,'`

	#We use ${0} to confuse M4... heh heh

	AC_OUTPUT_COMMANDS([
		#Only generate the fragment and stuff if the Makefile that includes it is
		#being rebuilt
		cfgmf="${BALSA_OFFSET_FRAG_DIR}Makefile"
		ping=`echo ${CONFIG_FILES} |grep ${cfgmf}`
		if test x"${ping}" != x -a x"${BALSA_OFFSET_TOOL_NO_RECURSE}" != xyes ; then
			chmod +x ${BALSA_OFFSET_TOOL_HOME}/${BALSA_OFFSET_TOOL_NAME}

	])

	AC_OUTPUT_COMMANDS(cat_command,cat_vars)

	AC_OUTPUT_COMMANDS([
			echo creating $1
			(cd ${BALSA_OFFSET_FRAG_DIR} && ${SHELL} ${BALSA_OFFSET_TOOL_DOTS}${BALSA_OFFSET_TOOL_HOME}/${BALSA_OFFSET_TOOL_NAME} \
				--makerules --fragname ${BALSA_OFFSET_FRAG_BASE} ${BALSA_OFFSET_SRCFILES} >${BALSA_OFFSET_FRAG_BASE})

			#Recreate the makefile with the new fragment included
			CONFIG_FILES=${cfgmf} CONFIG_HEADERS= BALSA_OFFSET_TOOL_NO_RECURSE=yes ${0}
		fi
	],[
		BALSA_OFFSET_TOOL_HOME="${BALSA_OFFSET_TOOL_HOME}"
		BALSA_OFFSET_TOOL_NAME="${BALSA_OFFSET_TOOL_NAME}"
		BALSA_OFFSET_TOOL_DEFSFILE="${BALSA_OFFSET_TOOL_DEFSFILE}"
		BALSA_OFFSET_TOOL_DOTS="${frag_dots}"
		BALSA_OFFSET_SRCFILES="${new_infiles}"
		BALSA_OFFSET_FRAG_BASE="${frag_basename}"
		BALSA_OFFSET_FRAG_DIR="${frag_subdir}"
	])

	undefine([cat_command])
	undefine([cat_vars])

	BALSA_OFFSET_SRCPATH="${srcdir}"
	BALSA_OFFSET_TOOL_DOTS="${frag_dots}"
	BALSA_OFFSET_MAKERULES=$1

	AC_SUBST_FILE(BALSA_OFFSET_MAKERULES)

	AC_SUBST(BALSA_OFFSET_TOOL_DEFSFILE)
	AC_SUBST(BALSA_OFFSET_TOOL_HOME)
	AC_SUBST(BALSA_OFFSET_TOOL_NAME)
	AC_SUBST(BALSA_OFFSET_TOOL_DOTS)
	AC_SUBST(BALSA_OFFSET_SRCPATH)
])
