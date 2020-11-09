#!/bin/bash
MODE="slozh"
value=1
(tail -f pipe) |
while true; do
	read LINE
	case $LINE in
		QUIT)
			echo "script ended"
			killall tail
			killall gen5.sh
			exit
				;;
		"*")
			MODE="umnozh"
				;;
		"+")
			MODE="slozh"
				;;
		*)
			reg='^[0-9]+$'
			
			if [[ $LINE =~ $reg ]];
			then
				if [[ $MODE == "umnozh" ]]
				then 
					let value=$value\*$LINE
				else 
					let value=$value+$LINE
				fi
				echo $value
			else 
				echo "script ended"
				killall tail
				killall gen5.sh
				exit
			fi
				;;
		
	esac
done
	
