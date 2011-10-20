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

[ 0 = "`id -u`" ] && OOPS must not be root

mkdir -p "$HOME/.monotone" &&
cat <<EOF >"$HOME/.monotone/monotonerc"

function intersection(a,b)
 local s={}
 local t={}
 for k,v in pairs(a) do s[v] = 1 end
 for k,v in pairs(b) do if s[v] ~= nil then table.insert(t,v) end end
 return t
end

function get_revision_cert_trust(signers, id, name, val)
 local trusted_signers = {
 "jrandom@i2p.net",
 "complication@mail.i2p",
 "zzz@mail.i2p",
 "dev@welterde.de"
 }
 local t = intersection(signers, trusted_signers)
 if t == nil then return false end
 if table.getn(t) >= 1 then return true end
 return false
end

EOF

mtn --db=i2p.mtn db init
#mtn --db=i2p.mtn read < i2p-maintainer-keys.txt
mtn --db=i2p.mtn pull mtn.i2p2.de i2p.i2p
mtn --db=i2p.mtn checkout --branch=i2p.i2p
