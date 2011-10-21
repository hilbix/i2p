#!/bin/bash
#
# Install all needed Debian packages.
#
# Apparently only is meaningful if you run Debian or Ubuntu

set -e
cd "`dirname "$0"`"
cd "`realpath .`"
cd ".."

OOPS()
{
echo "OOPS: $*" >&2
exit 1
}

[ 0 = "`id -u`" ] || OOPS this needs root

apt-get install monotone sun-java6-jdk ant libsqlite3-dev gnupg gawk
