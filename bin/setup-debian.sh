#!/bin/bash

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

apt-get install monotone sun-java6-jdk ant libsqlite3-dev
