#!/bin/bash
#
# Garrett Honeycutt - code@garretthoneycutt.com
#
# Released under GPLv2 - 2009-06-09
#
# concat all the .ics files into one from an iCal export
#
# usage: catics.sh <.icbu directory>
#

# ensure an argument is supplied
if [ ! $1 ]; then
    echo "usage: $0 <.icbu directory>"
    exit 1
fi

# ensure dir exists and is accessible
if [ ! -d $1 ]; then
    echo "Fail: $1 is not an accessible directory"
    exit 1
fi

# come up with filename
ICSFILE=$(echo $1 | /usr/bin/awk -F 'iCal' '{print $2}' | /usr/bin/awk -F \.icbu '{print $1}')

# concat the files
/usr/bin/find $1 -type f -name *.ics | /usr/bin/xargs /bin/cat > $ICSFILE.ics

exit 0
