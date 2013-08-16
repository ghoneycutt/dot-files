#!/bin/bash
#
# 2010-02-01 - Garrett Honeycutt - code@garretthoneycutt.com
#
# open a console with screen to my usb/rs232 adapter
# http://osx-pl2303.sourceforge.net/
#

BAUD=9600

/usr/bin/screen $(/bin/ls /dev/tty.PL2303-*) $BAUD
