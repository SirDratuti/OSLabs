#!/bin/bash
touch tmp
ps -e -o start,pid,command --no-header > tmp
cat tmp | grep -v "script3.sh" |  grep -v "ps -e -o start,pid,command --no-header" | tail -n 1 | awk '{print $2,$3}'
