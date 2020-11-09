#!/bin/bash

mkdir ~/test && 
{
	echo "catalog test was created succesfully" > ~/report 
	touch ~/test/$(date +"%m-%d-%Y_%H:%M")
}

ping -c 1 "net_nikogo.ru" || 
{
log=" name or service not known"
str=$(date +"%m-%d-%Y_%H:%M")$log
echo $str >> ~/report
}
