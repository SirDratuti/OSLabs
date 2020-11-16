#!/bin/bash


if [[ $# -ne 1 ]] 
then 
	echo "just 1 argument is needed"
	exit 1
fi
cd /home/andrew
name=$1
files=$(cat trash.log)
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
				if [ -e $filename ]
				then
					if [ -e $dir$1 ]
					then
						echo "file with this name is already exist, rename it?[Y/n]"
						read secAns
						if [ $secAns = "Y" ]
						then
							ln $filename "$dir$1$filename"
							rm $filename
						fi
					else 
						ln $filename $dir$1
						rm $filename
					fi
				else
					echo "file was already untrashed"
				fi
			else 
				cd /home/andrew/.trash
				echo "noDirectory"
				if [ -e $filename ]
				then
					cd /home/andrew
					if [ -e $1 ]
					then
						echo "file with this name is already exist, rename it?[Y/n]"
						read secAns
						if [ $secAns = "Y" ]
						then
							ln /home/andrew/.trash/$filename $1$filename
							rm /home/andrew/.trash/$filename
							echo "file was untrashed in home catalog"
						fi
					else 
						ln /home/andrew/.trash/$filename $1
						rm /home/andrew/.trash/$filename
						echo "file was untrashed in home catalog"
					fi
				else
					echo "file was already untrashed"
				fi
			fi
		fi	
	fi
done



