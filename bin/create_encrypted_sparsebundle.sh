#!/bin/bash
#
# 2010-11-08 - Garrett Honeycutt - code@garretthoneycutt.com
#
# Released under GPLv2
#
# Purpose: to create an encrypted sparsebundle
#
# Usage   : create_encrypted_sparsebundle.sh <destination prefix> <size in GB>
# Example : create_encrypted_sparsebundle.sh ~/work 2
#
# returns: 0 on success, non-zero on failure

# ensure arguments are passed
if [ $# -lt 2 ]; then
    echo "Usage: $0 <destination prefix> <size in GB>"
    exit 1
fi

DEST=${1}.sparsebundle
SIZE=$2

# check if the sparsebundle already exists
if [ -d ${DEST} ]; then
    echo "Fail: ${DEST} already exists"
    exit 1
fi

# set volume name to be the filename, minus the .sparsebundle bit
VOLNAME=$(basename ${DEST} | awk -F .sparsebundle '{print $1}')

# create the sparse bundle
/usr/bin/hdiutil create -encryption -stdinpass -type SPARSEBUNDLE -fs HFS+J -volname ${VOLNAME} -size ${SIZE}g ${DEST}
if [ $? -ne 0 ]; then
    echo "Fail: hdiutil returned nonzero"
    exit 1
fi

exit 0
