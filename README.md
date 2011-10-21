Warnings
========

This is not an official I2P repository
--------------------------------------

The official I2P repository is at i2p2.de.  You can get it with:

```bash
mtn --db=i2p.mtn db init
mtn --db=i2p.mtn pull mtn.i2p2.de i2p.i2p
mtn --db=i2p.mtn checkout --branch=i2p.i2p
```

However this is only half of the story.  The full story can be found in this repository.


This may contain bugs
---------------------

https://github.com/hilbix/i2p/ contains a copy of the I2P distribution in a version which I run on my routers.  I try to keep this repository clean from other local changes.

If you have normal trouble please don't ask me, I do not have time for this.  Fork it, fix it and perhaps send me a pull request.  Thanks.

But if you find some serious problem, related to security, please let me know.  The fastest way to reach me is to use my pager:

URL: https://hydra.geht.net/pager.php

This can be reached as http://www.tino.i2p/pager.php from within I2P (if my main router is up and running).


License
-------

This here has a very mixed license.  I2P partly is PD, partly has other Open Source licenses.  Please respect them.


About
=====

I2P is an anonymous network.  It is a bit different from TOR and Freenet.  For more information on I2P please look at http://www.i2p2.de/

This here was created because I cannot understand how to use monotone.  I tried numerous times, I failed each time, so I gave up.

However I know how GIT works.  Setting up a GIT server even is more easy and versatile than a CVS server, GIT is lightning fast, is rock stable, is cryptographically secure out of the box and fully distributed, too.  GIT is the only VCS which convinced me that it is superior to good old CVS.  And even that took years, as I am a really die-hard hardcore CVS junkie.

So this here is my helpless attempt to transform the development repository of I2P into something suitable for me.  That's all.

I only will keep this up to date when I need it.  Usually this is when I patch the I2P routers for my I2PinProxy http://i2p.to/


Quirks
======

This here comes with a compilation of i2p-maintainer-keys.txt which must be considered insecure.  **Never trust a third party.**

Having said this, I must add that it is somewhat difficult to get all the pieces together.  So it is likely that I err, and so you should review things first.  The best thing always is 3rd party reviews.  Those can be easily done on GitHub, of course.


Build
=====

Initial
-------

```bash
git clone https://github.com/hilbix/i2p
sudo bin/setup-debian.sh
cd i2p.i2p
ant pkg
```

Later
-----

```bash
bin/update.sh [branch]
```


Branches
========

* master: This contains the official, unmodified repository so far.
* tino: This is my private repository which contains my local changes.


Usage
=====

There are a couple of files in bin/ - they should have a comment at the beginning what they do.

There are a couple of files in files/ which are used by the scripts in bin/

The most important scripts:

`bin/update.sh` [branch]
	Pulls latest branch from GIT and builds the updater by calling `ant updater`

`bin/setup-mtn.sh`
	Extremely slow: Pulls the source i2p.mtn from mtn.i2p2.de and checks them.

`bin/verify-jrandom.sh`
	Verifies the integrity of the base of i2p.mtn by comparing it to the lastest JRandom I2P 0.6.1.30 release.
	This is not yet really complete.


Bugs
====

* bin/setup-debian.sh is not yet tested against a minimal Debian VM, so it probably does not pull everything which is needed.


FAQ
===

* Jetty download fails with "Network unreachable" / Caveats when IPv6 is available:
	Check `/proc/sys/net/ipv6/bindv6only` is `0`.  If not edit `/etc/sysctl.d/bindv6only.conf` and set `net.ipv6.bindv6only=0`.  run `sudo sysctl net.ipv6.bindv6only=0` to set this parameter, too.  See also URL http://zzz.i2p.to/topics/653

* How to install I2P and get it started?
	`adduser i2p; su - i2p; java -jar /path/to/installer.jar -console`
	Install it to `/home/i2p/i2p`, then `cd i2p/; ./i2psvc wrapper.cfg`
	`lynx http://127.0.0.1:7657/`
	This short answer here is not meant to be complete.

* How to update I2P?
	`cd i2p.i2p; ant updater`
	`su - i2p; cp /path/to/update.zip i2p/`
	Restart the router

