# Note that this is NOT a relocatable package
%define ver      0.99.5
%define rel      SNAP
%define prefix   /usr

Summary: Gnome Common
Name: gnome-common
Version: %ver
Release: %rel
Copyright: LGPL
Group: X11/Libraries
Source: ftp://ftp.gnome.org/pub/GNOME/sources/gnome-common/gnome-common-%{ver}.tar.gz
BuildRoot: /tmp/gnome-common-root
URL: http://www.gnome.org
Docdir: %{prefix}/doc

%description
This is required for every GNOME Application that is not in the
GNOME CVS Tree.

%package devel
Summary: Required files for GNOME Applications outside CVS
Group: X11/libraries

%description devel
This is required for every GNOME Application that is not in the
GNOME CVS Tree.

%prep
%setup

%build
# Needed for snapshot releases.
if [ ! -f configure ]; then
  CFLAGS="$RPM_OPT_FLAGS" ./autogen.sh --prefix=%prefix
else
  CFLAGS="$RPM_OPT_FLAGS" ./configure --prefix=%prefix
fi

if [ "$SMP" != "" ]; then
  (make "MAKE=make -k -j $SMP"; exit 0)
  make
else
  make
fi

%install
rm -rf $RPM_BUILD_ROOT

make prefix=$RPM_BUILD_ROOT%{prefix} install

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-, root, root)

%doc AUTHORS COPYING ChangeLog NEWS README

%files devel
%defattr(-, root, root)

%{prefix}/share/aclocal/gnome/*

