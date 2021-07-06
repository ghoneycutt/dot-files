#!/bin/bash
#
# Garrett Honeycutt - code@garretthoneycutt.com - 2009
#
# Released under GPLv2
#
# returns 0 on sucess, non-zero on failure
#
# Usage: genpasswd.sh [minum password length] [maximum password length]
#
# Notes: uses 10 as the default for min/max. Min has to be at least 4. 

APG="/usr/local/bin/apg"

# set defaults
MIN=20
MAX=20

# if only min is specified, use it and set max to the same number
if [ $# -eq 1 ]; then
    MIN=$1
    MAX=$1
fi

# if min and max are specified, use them
if [ $# -gt 1 ]; then
    MIN=$1
    MAX=$2
fi

# must be at least 4 characters wide to comply with strictness,
# else set to 4
if [ $MIN -lt 4 ]; then
    MIN=4
fi

# check that max is also 4 characters wide, else set to MIN
if [ $MAX -lt 4 ]; then
    MAX=$MIN
fi

# display passwords
$APG -M SNCL -m ${MIN} -x ${MAX}
if [ $? -ne 0 ]; then
    echo "Fail: apg returned nonzero"
    exit 1
fi

exit 0
