#!/bin/bash


maxSize=$1
array=()
iter=1
echo "" > report.log
while true;
do
	array+=(1 2 3 4 5)
	if [[ "${#array[*]}" -gt "$maxSize" ]]
	then
		exit
	fi
	let "iter=$iter+1"
done
