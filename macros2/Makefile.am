## Please update this variable if any new macros are created

HACK_MACROS=					\
  gnome.m4					\
  gnome-common.m4

EXTRA_DIST=$(HACK_MACROS) autogen.sh
MAINTAINERCLEANFILES=macros2.dep

@MAINT@macros2.dep: Makefile.am
@MAINT@	@echo '$$(top_srcdir)/aclocal.m4: $(HACK_MACROS:%=hack-macros/%)' > $@

if INSIDE_GNOME_COMMON
gnome2_aclocaldir = $(datadir)/aclocal/gnome2-macros

gnome2-macros.dep: Makefile.am
	@echo '$$(top_srcdir)/aclocal.m4: $(HACK_MACROS:%=$(gnome_aclocaldir)/%)' > $@

gnome2_aclocal_DATA = $(HACK_MACROS) autogen.sh gnome2-macros.dep

endif
