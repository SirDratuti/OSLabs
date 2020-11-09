#!/bin/bash

pid=$(pgrep plus4.sh | sort -n | head -n 1)
cpulimit -p $pid -l 10 >/dev/null &

