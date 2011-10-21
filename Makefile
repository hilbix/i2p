# For the lasy sysadmin.  That's me ;)

all:	i2p.i2p

clean:	i2p.i2p
	cd i2p.i2p; ant distclean

update:		i2p.i2p
	bin/update.sh

fix:
	find . -type f -name .gitignore -size 0 -exec rm -vf \{\} \;
	find . -type d -empty -exec touch \{\}/.gitignore \;

i2p.i2p:	| i2p.mtn
	bin/mtn-checkout.sh

.SECONDARY: i2p.mtn
.PRECIOUS: i2p.mtn
i2p.mtn:
	bin/setup-mtn.sh

