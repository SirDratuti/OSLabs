#!/bin/bash

while true;
do

top -b -n 1 | grep "MiB" >> top
top -b -n 1 | grep "mem.bash" >> top
top -b -n 1 | grep "mem2.bash" >> top
echo "HELLO"

sleep 3
done 
