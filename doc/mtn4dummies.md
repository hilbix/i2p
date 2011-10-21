Monotone for dummies
====================

Things I cannot remember

Commands
--------

mtn up
	Use this command only after commit.
	Without arguments it moves to the head.
	Q: What happens if there is more than one head?

mtn up -r t:TAGNAME
	Switch to another tag

mtn heads
	Shows all current heads.
	In case of a fork there can be more than a head

mtn merge
	Merge the heads.  Mostly automatic.

mtn ls tags '*-0.*'
	List all known tags, reduce to more recent names.
	Q: Is there "show all tags of the last 2 weeks"?

