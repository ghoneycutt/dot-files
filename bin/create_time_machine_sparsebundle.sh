#!/bin/bash
#
# 2009-12-27 - Garrett Honeycutt - code@garretthoneycutt.com
#
# Released under GPLv2
#
# Purpose: to create a sparsebundle which Time Machine will use automatically
#
# Usage   : create_time_machine_sparsebundle.sh <destination directory> <size in GB>
# Example : create_time_machine_sparsebundle.sh /Volumes/ExternalHD 100
#
# returns: 0 on success, non-zero on failure
#
# Notes: This is particulary useful if you are using a Drobo or another device
#        that lies about its volume size, so that you can easily grow it later.
#        Without using a sparse bundle, Time Machine would backup more data
#        than the actual disk space. Recommendation for backup size is 2x the
#        amount of data you are backing up.

# ensure argument is passed
if [ $# -lt 2 ]; then
    echo "Usage: $0 <destination directory> <size in GB>"
    exit 1
fi

DESTDIR=$1
SIZE=$2

# get hostname
HOSTNAME=$(/bin/hostname -s)
if [ $? -ne 0 ]; then
    echo "Fail: hostname returned nonzero"
    exit 1
fi

# get mac and format appropriately for Time Machine
MAC=$(/sbin/ifconfig en0 | /usr/bin/grep ether | /usr/bin/awk '{print $2}' | /usr/bin/sed -e 's/://g')
if [ $? -ne 0 ]; then
    echo "Fail: finding the MAC address was unsuccessful for en0"
    exit 1
fi

# check if the sparsebundle already exists
if [ -d ${DESTDIR}/${HOSTNAME}_${MAC}.sparsebundle ]; then
    echo "Fail: ${DESTDIR}/${HOSTNAME}_${MAC}.sparsebundle already exists"
    exit 1
fi

# create the sparse bundle
/usr/bin/hdiutil create -size ${SIZE}g -fs HFS+J -volname "Time Machine Backup" ${DESTDIR}/${HOSTNAME}_${MAC}.sparsebundle
if [ $? -ne 0 ]; then
    echo "Fail: hdiutil returned nonzero"
    exit 1
fi

exit 0
