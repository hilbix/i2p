# For the lasy sysadmin.  That's me ;)

all:	i2p.i2p

update:		i2p.i2p
	bin/update.sh

fix:
	find . -type f -name .gitignore -size 0 -exec rm -vf \{\} \;
	find . -type d -empty -exec touch \{\}/.gitignore \;

i2p.i2p:	| i2p.mtn
	bin/mtn-checkout.sh

i2p.mtn:
	bin/setup-mtn.sh

