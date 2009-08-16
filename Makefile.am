SUBDIRS = macros2 doc-build

EXTRA_DIST = \
	autogen.sh \
	gnome-common.spec \
	gnome-common.spec.in \
	doc/usage.txt \
	ChangeLog.pre-git

# Build ChangeLog from GIT  history
ChangeLog:
	$(AM_V_GEN) if test -d $(top_srcdir)/.git; then \
		GIT_DIR="$(top_srcdir)/.git" git log --stat > $@; \
	fi

dist: ChangeLog

.PHONY: ChangeLog
