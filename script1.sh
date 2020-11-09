#!/bin/bash

touch u
ps -U andrew --no-header > u
cat u | grep -v "script1.sh" |  grep -v "ps$"  > u2
cat u2 | wc -l > ans1.lst
cat u2 | awk '{print $1,":",$4}' >> ans1.lst
rm u
