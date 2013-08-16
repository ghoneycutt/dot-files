#!/bin/bash
#
# 2010-11-08 - Garrett Honeycutt - code@garretthoneycutt.com
#
# Released under GPLv2
#
# Purpose: to mount a sparsebundle in its current location
#
# Usage   : mount_sparsebundle.sh <path to .sparsebundle>
# Example : mount_sparsebundle ~/work.sparsebundle
#
# returns: 0 on success, non-zero on failure

# ensure arguments are passed
if [ $# -lt 1 ]; then
    echo "Usage: $0 <path to .sparsebundle>"
    exit 1
fi

mount_sparsebundle() {
    /usr/bin/hdiutil attach -encryption -stdinpass -mountpoint ${DESTDIR} ${SPARSEBUNDLE}
    if [ $? -ne 0 ]; then
        echo "Fail: hdiutil returned nonzero"
        exit 1
    fi
} # mount_sparsebundle

SPARSEBUNDLE=$1
DESTDIR=$( echo $1 | awk -F .sparsebundle '{print $1}' )

# check if the directory in which we will mount the sparsebundle exists
# if it does not, create it
if [ ! -d ${DESTDIR} ]; then
    mkdir -p ${DESTDIR}
fi

# check if the sparsebundle is already mounted and if so then exit
MOUNTPATH=$( mount | grep "(hfs, local, nodev, nosuid, journaled," | grep test | awk '{print $3}' )
# $MOUNTPATH is empty, so mount the sparsebundle
if [ -z ${MOUNTPATH} ]; then
    mount_sparsebundle
else
    # $MOUNTPATH is not empty and if it does not match the DESTDIR, then mount the sparsebundle
    if [ ${MOUNTPATH} != ${DESTDIR} ]; then
        mount_sparsebundle
    fi
fi

exit 0
