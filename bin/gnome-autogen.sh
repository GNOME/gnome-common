#!/bin/sh

if test -z "$GNOME_DATADIR" ; then
  GNOME_DATADIR=`gnome-config --datadir`
fi

if test -n "$USE_GNOME2_MACROS" ; then
  export GNOME_COMMON_MACROS_DIR="$GNOME_DATADIR/aclocal/gnome2-macros"
else
  export GNOME_COMMON_MACROS_DIR="$GNOME_DATADIR/aclocal/gnome-macros"
fi

export ACLOCAL_FLAGS="-I $GNOME_COMMON_MACROS_DIR $ACLOCAL_FLAGS"
. $GNOME_COMMON_MACROS_DIR/autogen.sh

