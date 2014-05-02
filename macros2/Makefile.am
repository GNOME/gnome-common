## Please update this variable if any new macros are created

GNOME2_MACROS = \
  gnome-common.m4 \
  gnome-compiler-flags.m4 \
  gnome-code-coverage.m4

# Macros copied from the autoconf-archive.
#     http://www.gnu.org/software/autoconf-archive/
# these should be dropped as soon as the deprecated GNOME2_MACROS which use them
# are removed. Until then, they should be kept up to date, and all changes to
# them submitted upstream.
AUTOCONF_ARCHIVE_MACROS = \
	ax_check_enable_debug.m4 \
	$(NULL)

EXTRA_DIST = $(GNOME2_MACROS) $(AUTOCONF_ARCHIVE_MACROS) gnome-autogen.sh

aclocaldir = $(datadir)/aclocal
aclocal_DATA = $(GNOME2_MACROS) $(AUTOCONF_ARCHIVE_MACROS)

bin_SCRIPTS = gnome-autogen.sh
