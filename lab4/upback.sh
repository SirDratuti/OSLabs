#!/bin/bash

cd /home/andrew
if [[ ! -d restore ]]
then 
	mkdir restore
fi

back="$(ls | grep -E "^Backup-" | sort -n | tail -1 )"
cd /home/andrew/$back
files="$(ls)"
for i in $files
do
	notOnly="$(echo "$i" | grep -E -o '^[A-Za-z0-9]+-[0-9]+-[0-9]+-[0-9]+')"
	if [ "$i" != "$notOnly" ]
	then
		cp -R $i /home/andrew/restore
	fi
done
