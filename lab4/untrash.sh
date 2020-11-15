#!/bin/bash


if [[ $# -ne 1 ]] 
then 
	echo "just 1 argument is needed"
	exit 1
fi
cd /home/andrew
name=$1
files=$(cat trash.log)
echo "">trash.log
for i in $files
do
	if [[ $i =~ "$name:" ]]
	then
		echo $i
		echo "Restore?[Y/n]"
		read ans
		if [ $ans = "Y" ]
		then
			cd /home/andrew/.trash
			filename=$(echo $i | awk -F":" '{print $2}')
			dir="$(echo $i | awk -F":" '{print $1}' | grep -o ".*/")"
			dirname=$(echo $dir | rev | cut -c 2- | rev)
			if [ -d $dirname ]
			then
				if [ -e $dir$1 ]
				then
					echo "file with this name is already exist, rename it?[Y/n]"
					read secAns
					if [ $secAns = "Y" ]
					then
						ln $filename "$dir$1$filename"
						rm $filename
					else 
						echo $i >>trash.log
					fi
				else 
					ln $filename $dir$1
					rm $filename
				fi
			else 
				cd /home/andrew
				echo "noDirectory"
				if [ -e $1 ]
				then
					echo "file with this name is already exist, rename it?[Y/n]"
					read secAns
					if [ $secAns = "Y" ]
					then
						ln $filename $1$filename
						rm /home/andrew/.trash/$filename
					else 
						echo $i >>/home/andrew/trash.log
					fi
				else 
					ln $filename $1
					rm /home/andrew/.trash/$filename
				fi
			fi
		fi
	else
		echo $i >>/home/andrew/trash.log	
	fi
done




