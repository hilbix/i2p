#!/bin/bash
#
# Setup Monotone - START HERE if you want to pull I2P from official sources
#
# This is mainly for bootstrapping to get the sources out of Monotone
# into GIT.  Usually you do not need to run it, except the
# GIT repo is outdated and you want to update it.

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

cat <<EOF

WARNING!

This pulls over 60 MiB of data over a really slow link.
It will take an hour or more.

If it stalls for 15 minutes or so, do not interrupt.
And if you think you waited long enough, wait a bit longer.

EOF

bin/setup-mtn-trust.sh

# If you want to start from scratch because you have messed up i2p.mtn, just
#	rm -f i2p.mtn
# It is then quickly rebuild from i2p.mtn.dist, provided that is still around
[ ! -s i2p.mtn ] && [ -f i2p.mtn.dist ] && cp i2p.mtn.dist i2p.mtn

[ -f i2p.mtn ] || mtn --db=i2p.mtn db init

bin/mtn-pull.sh
cp i2p.mtn i2p.mtn.dist

bin/verify-mtn-keys.sh

