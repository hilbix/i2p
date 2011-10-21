# For the lasy sysadmin.  That's me ;)

all:	i2p.i2p

i2p.i2p:	| i2p.mtn
	bin/mtn-checkout.sh

i2p.mtn:
	bin/setup-mtn.sh

