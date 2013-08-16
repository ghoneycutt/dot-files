#!/bin/bash
#
# generate a random MAC address
#
# Garrett Honeycutt - code@garretthoneycutt.com - 20100416
#
# Released under GPLv3
#
/bin/echo -n "c0:ff:ee"
for ((i=1;i<=3;i++))
do
    /bin/echo -n $(/bin/echo ":${RANDOM}${RANDOM}" | /bin/cut -n -c -3)
done
