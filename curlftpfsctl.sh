#!/bin/bash

### CREDENTIALS
HOST="1.2.3.4"
USER="root"
PASSWORD="changeme"
FOLDER="/mnt/"

### TWEAKS
GID=`id -u`
CONNECT_COMMAND="curlftpfs -o utf8 -o uid=$UID,gid=$GID,nonempty,allow_other $USER:$PASSWORD@$HOST $FOLDER"
DISCONNECT_COMMAND="fusermount -u $FOLDER"
CONNECT_INDICATOR_FILE=".online_mounted"
DISCONNECT_INDICATOR_FILE=".offline_not_mounted"

### API
function connect_cloud {
	if [ ! -f "$FOLDER/$CONNECT_INDICATOR_FILE" ]; then
		sh -c "$CONNECT_COMMAND"
		echo "Connected"
	else
		echo "Already online"
	fi
	exit 0
}

function disconnect_cloud {
	if [ ! -f "$FOLDER/$DISCONNECT_INDICATOR_FILE" ]; then
		sh -c "$DISCONNECT_COMMAND"
		echo "Disconnected"
	else
		echo "Already offline"
	fi
	exit 0
}

function status {
	if [ -f "$FOLDER/$CONNECT_INDICATOR_FILE" ]; then
		echo "Online"
	elif [ -f "$FOLDER/$DISCONNECT_INDICATOR_FILE" ]; then
		echo "Offline"
	else
		echo "Unknown. Create file \"$CONNECT_INDICATOR_FILE\" in $FOLDER after connectig and file \"$DISCONNECT_INDICATOR_FILE\" after disconncting"
	fi
}

### CLI
case "$1" in
	"connect" )
		connect_cloud;;
	"disconnect" )
		disconnect_cloud;;
	"status" )
		status;;
	*)
		echo "usage: $0 (connect|disconnect|status)"
		exit 1;;
esac
