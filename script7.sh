#!/bin/bash
touch temp
touch temp2
for pid in $(ps -eo pid)
do
read_bytes=$(grep -s read_bytes /proc/$pid/io | grep -E -o '[0-9]+' | awk '{print $0}')
if [[ $read_bytes -gt 0 ]]
then
	echo $pid $read_bytes >> temp
fi
done
sleep 60
for pid in $(ps -eo pid)
do
new_bytes=$(grep -s read_bytes /proc/$pid/io | grep -E -o '[0-9]+' | awk '{print $0}')
if [[ $new_bytes -gt 0 ]]
then
	old_bytes=$(grep -E "^$pid" temp | awk '{print $2}')
	if [[ $old_bytes -gt 0 ]]
	then
		diff=$(($new_bytes-$old_bytes))
		echo $pid $diff $(ps -eo pid,command | awk '{print $1,$2}' | grep $pid | awk '{print $2}') >> temp2
	fi
fi
done
sort -n -k2 temp2 | tail -n 3 | awk '{print $1,":",$3,":",$2}'
rm temp
rm temp2
