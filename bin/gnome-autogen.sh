#!/bin/sh

if test -z "$GNOME_DATADIR" ; then
  if test -z "$GNOME_DIR" ; then
    GNOME_DATADIR=`gnome-config --datadir`
  else
    GNOME_DATADIR="$GNOME_DIR/share"
  fi
fi

if test -n "$USE_GNOME2_MACROS" ; then
  export GNOME_COMMON_MACROS_DIR="$GNOME_DATADIR/aclocal/gnome2-macros"
else
  export GNOME_COMMON_MACROS_DIR="$GNOME_DATADIR/aclocal/gnome-macros"
fi

export ACLOCAL_FLAGS="-I $GNOME_COMMON_MACROS_DIR $ACLOCAL_FLAGS"
. $GNOME_COMMON_MACROS_DIR/autogen.sh

