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

```bash
git clone https://github.com/hilbix/i2p
cd i2p.i2p
ant pkg
```


Branches
========

* master: This contains the official, unmodified repository so far.
* tino: This is my private repository which contains my local changes.

Note that you can find all other branches and tags from mercurial, too, as I use hg-git to pull data into GIT.

