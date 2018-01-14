#!/bin/bash
if [ -z "$*" ]; then
	echo "usage: $0 min max"
	exit 1;
fi

echo $(( ( RANDOM % ( $2 + 1 ) )  + $1 ));

