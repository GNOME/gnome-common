## if <internationalization support>
#SUBDIRS = po intl macros support # <your subdirs here>
## else
SUBDIRS = macros support # <your subdirs here>
## endif

## to automatically rebuild aclocal.m4 if any of the macros in
## `macros/' change
@MAINT@include macros/macros.dep
@MAINT@macros/macros.dep: macros/Makefile.am
@MAINT@	cd macros && $(MAKE) macros.dep
