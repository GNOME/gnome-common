if PLATFORM_GNOME_2
pkgconfig_file = gnome-common-2.0.pc
support = support
else
pkgconfig_file =
support =
endif

SUBDIRS = bin macros macros2 doc $(support)

EXTRA_DIST = gnome-common.spec gnome-common-2.0.pc.in gnome-common.pc.in

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = $(pkgconfig_file) gnome-common.pc

