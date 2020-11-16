#!/bin/bash

if [[ $# -ne 1 ]] 
then 
	echo "just 1 argument is needed"
	exit 1
fi


name=$1
numb=$(cat number)

if [[ -e $PWD/$name ]]
then 
	echo "file \"$1\" exist"
else 
	echo "no file \"$1\""
	exit 1
fi

if [[ -d ~/.trash ]] 
then 
	echo "directory \".trash\" is already exist"
else 
	mkdir ~/.trash
fi

ln $name "$HOME/.trash/$numb"
rm $1
echo "$PWD/$name:$numb" >> ~/trash.log
let numb=$numb+1
echo $numb>number
