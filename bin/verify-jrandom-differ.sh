#!/bin/bash
#
# A diff tester with some fix to ignore diff parts resulting from
# CVS tags only

set -e

diff -Nr "$@" 2>>verify.err |

# We could probably check more thoroughly for CVS tags,
# as they have a very fixed format
# (sed as AWK does not support back ref within regexp)
sed '
/^\([1-9][0-9]*\)c\1$/d
/^---$/d
s/\$\([IRD][adeinostv]*\): [^$]*\$/$\1$/g
' |

gawk '
BEGIN		{ err=0 }
		{ print }
/^diff /	{ start=1; line=$0; next; }
/^</		{ start++; first=substr($0,2); next }
/^>/		{ if (first!=substr($0,2) || start!=2) err=1;start=1; next }
		{ err=1 }
END		{ exit(start>1 ? 1 : err); }
' > verify.out

[ ! -s verify.err ] && rm -f verify.err

echo "Verification OK"
