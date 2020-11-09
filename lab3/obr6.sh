#!/bin/bash

echo $$ > .pid
value=1
MODE="slozh"
usr1()
{
	MODE="slozh"
}
usr2()
{
	MODE="umnozh"
}
trap 'usr2' USR2
trap 'usr1' USR1
while true; do
	case $MODE in
		"slozh")
			let value=$value+1
			echo $value
			MODE="wait"
				;;
		"umnozh")
			let value=$value\*2
			echo $value
			MODE="wait"
				;;
		*)
			:
				;;
	esac
	sleep 1;
done
