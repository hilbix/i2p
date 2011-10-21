#!/bin/bash
#
# Tries to verify that the base of the monotone sources
# indeed is based on the sources from JRandom.
#
# JRandom was the founder of the I2P project, until he disappeared.
#
# See also
#	http://www.i2p2.de/monotone.html

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

cat << EOF

This verifies that the 0.6.1.30 tarball of I2P

EOF

"`dirname "$0"`/setup-gpg.sh"

gpg --verify i2p-0.6.1.30.tar.bz2.sig i2p-0.6.1.30.tar.bz2

wget -c mirror.i2p2.de/i2p-0.6.1.30.tar.bz2
wget -c mirror.i2p2.de/i2p-0.6.1.30.tar.bz2.sig

TMP="verify.tmp.$$"

rm -rf "$TMP"
mkdir "$TMP"

cd "$TMP"

set -x
tar xfj ../i2p-0.6.1.30.tar.bz2
mtn --db="../i2p.mtn" co --revision="928aadc3796083b8412829c2d18e95fdeecd8196"
set +x
rm -rf i2p.i2p/_MTN

cd ..

bin/verify-jrandom-differ.sh "$TMP/i2p_0_6_1_30" "$TMP/i2p.i2p" || OOPS "verification failed"

rm -rf "$TMP"
