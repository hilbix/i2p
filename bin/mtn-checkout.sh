#!/bin/bash
#
# Do a Monotone checkout
#
# Usually you do not need that, except you want to recreate i2p.i2p

set -e
cd "`dirname "$0"`"
cd "`realpath .`"
cd ".."

OOPS()
{
echo "OOPS: $*" >&2
exit 1
}

[ 0 = "`id -u`" ] && OOPS must not be root

[ -d i2p.i2p ] || mtn --db=i2p.mtn checkout --branch=i2p.i2p

