#!/bin/bash

if [ "$EUID" -ne "0" ]
  then echo "Please run as root"
  exit 1
fi

#Default location is /usr/lib/slack/resources/app.asar.unpacked/src/static/ssb-interop.js

SSB_INTEROP_FILE=/usr/lib/slack/resources/app.asar.unpacked/src/static/ssb-interop.js

if [ ! -f "$SSB_INTEROP_FILE" ]; then
	SSB_INTEROP_FILE=`grep -m1 "" path.txt 2> /dev/null`
fi
if [ ! -f "$SSB_INTEROP_FILE" ]; then
	echo "Cannot find path to ssb-interop.js, find the path to this find and create a path.txt file with this path as the first and only line"
fi

SNIPPET_SCRIPT="$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")"/darktheme_snippet.js

if grep -Fq '/* Dark theme applied */' $SSB_INTEROP_FILE
then 
	echo 'Dark theme already applied'
else
	echo 'Applying theme...'
	cat $SNIPPET_SCRIPT >> $SSB_INTEROP_FILE
	echo 'Done applying theme.'
fi
