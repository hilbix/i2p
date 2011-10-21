#!/bin/bash
#
# Create updater
#
# The update.zip should then be copied into ~i2p/i2p/ and I2P restarted

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

git pull
cd i2p.i2p
ant updater

