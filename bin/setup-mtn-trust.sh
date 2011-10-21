#!/bin/bash
#
# Install the trust hook into Monotone
#
# If the trust hook cannot be found, return error
# (this stops the build process by purpose)
#
# See also:
#	http://zzz.i2p.to/topics/506
#	http://zzz.i2p.to/topics/649
#	http://www.i2p2.de/license-agreements.html

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

RC="$HOME/.monotone/monotonerc"
HOOK="files/trust.monotonerc"


mkdir -p "`dirname "$RC"`"
if [ ! -f "$RC" ]
then
	cat < "$HOOK" >>"$RC"
else
	if	diff "$RC" "$HOOK" | grep '^>'
	then
		cat << EOF

The trust hook cannot be found ir has changed (see the diff above).
Hook file: $HOOK
RC file:   $RC

To fix that, there are two options:

If the RC filedoes not contain valuable data:
	rm -f '$RC'
Then run this here again.  If you have no idea of Monotone as it is
exclusively used here, then this is probably what you need.

If the file $RC cannot be destroyed like this:
	cat '$HOOK' >>'$RC'
	vi '$RC'
After editing it properly, run this here again.  As you edited the RC,
you probably know what you have to do.  If not, sorry, ask some
Monotone Guru, not me, I have no idea how to hack Monotone properly.

If you need changes to the hook, you have to edit the hook first:
	vi '$HOOK'
(If it cannot be found literally, it is assumed missing.)

EOF
		OOPS "trust hook not properly in $RC"
	fi
	true
fi
