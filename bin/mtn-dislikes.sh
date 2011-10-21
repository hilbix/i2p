#!/bin/bash
#
# For lazy myself, because this way I do not need to remember

dislike()
{
mtn --db=i2p.mtn list cert "$1"
}

if [ 0 = "$#" ]
then
	while read -r a
	do
		dislike "$a"
	done
else
	for a
	do
		dislike "$a"
	done
done
