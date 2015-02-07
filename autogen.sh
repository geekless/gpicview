#!/bin/sh
AC_VERSION=

AUTOMAKE=${AUTOMAKE:-automake}
AM_INSTALLED_VERSION=$($AUTOMAKE --version | sed -e '2,$ d' -e 's/.* \([0-9]*\.[0-9]*\).*/\1/')

if [ "$AM_INSTALLED_VERSION" != "1.11" \
    -a "$AM_INSTALLED_VERSION" != "1.12" \
    -a "$AM_INSTALLED_VERSION" != "1.13" \
    -a "$AM_INSTALLED_VERSION" != "1.14" \
    -a "$AM_INSTALLED_VERSION" != "1.15" ];then
	echo
	echo "You must have automake 1.11...1.15 installed to compile spicview."
	echo "Install the appropriate package for your distribution,"
	echo "or get the source tarball at http://ftp.gnu.org/gnu/automake/"
	exit 1
fi

set -x

if [ "x${ACLOCAL_DIR}" != "x" ]; then
  ACLOCAL_ARG=-I ${ACLOCAL_DIR}
fi

${ACLOCAL:-aclocal$AM_VERSION} ${ACLOCAL_ARG}
${AUTOHEADER:-autoheader$AC_VERSION} --force
AUTOMAKE=$AUTOMAKE libtoolize -c --automake --force
AUTOMAKE=$AUTOMAKE intltoolize -c --automake --force
$AUTOMAKE --add-missing --copy --include-deps
${AUTOCONF:-autoconf$AC_VERSION}

rm -rf autom4te.cache
