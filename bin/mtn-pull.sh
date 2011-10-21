#!/bin/bash
#
# Pull the I2P development source.
#
# This probably is only needed if you want to sync
# GIT to the latest sources.

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

mtn --db=i2p.mtn pull mtn.i2p2.de i2p.i2p

