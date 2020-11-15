#!/bin/bash

cd /home/andrew
now="$(date +%Y-%m-%d)"
prev="$(ls | grep -E "^Backup-" | sort -n | tail -1 | cut -d "-" -f 2,3,4)"

sNow="$(date -d "$now" +%s)"
sprev="$(date -d "$prev" +%s)"

let diff=($sNow-$sprev)/60/60/24

if [[ $diff -gt 7 ]]
then 
	mkdir "Backup-$now"
	cd /home/andrew/source
	files="$(ls)"
	for i in files
	do
		cp -R $i ~/Backup-$now
	done
	cd /home/andrew
	echo "Backup was created $now" >> backup-report
	echo "Copied this files: " >> backup-report
	echo $files >> backup-report
	
else
	cd /home/andrew/source
	files="$(ls)"
	cd /home/andrew/Backup-$prev
	
	for i in $files 
	do
		if [ -f $i ]
		then
			currentSize=$(ls -l /home/andrew/source/$i | awk '{print $5}')
			backSize=$(ls -l $i | awk '{print $5}')
			if [[ $currentSize -ne $backSize ]]
			then
				mv $i $i-$now
				cp -R /home/andrew/source/$i /home/andrew/Backup-$prev
				echo "$i was renamed to $i-$now" >> /home/andrew/backup-report
			fi
		else
			cp -R /home/andrew/source/$i /home/andrew/Backup-$prev
		fi
	done	
fi

