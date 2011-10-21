#!/bin/bash
#
# Verify the public transportation keys found in the Monotone repository
# with official sources.
#
# Sadly I was unable to locate proper signatures for all of them yet.
# Those are listed here as files/*.pub with a missing files/*.pub.sig
#
# Having them in GIT is better than nothing.
# One hash to find them, well, sort of. ;)

echo TBD
exit 1
#[ 0 != "`id -u`" ] && exec cat files/*.pub files/*.pgp | mtn --db=i2p.mtn read
