#!/bin/bash
#
# Setup GnuPG with all keys, and check all the signatures.
#
# Prerequisite for some scripts which verivy integrity.
# Note that a failure must be considered fatal.
#
# See also
#	http://www.i2p2.de/monotone.html
#	http://www.i2p2.i2p/license-agreements.html

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

for key in 0x065E37EE 0x393F2DF9 0x79FCCE33 0x62E011A1 0xA76E0BED
do
	( gpg --list-key "$key" || gpg --recv-key "$key"; )
done

set -x
for sig in files/*.sig
do
	gpg --verify "$sig" "${sig%.sig}"
done
for sig in files/*.pgp
do
	gpg --verify "$sig"
done
