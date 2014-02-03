#!/bin/bash

tickets=1
user='rjg70'
event="MCR Formal"

# read number of tickets required from command line. DEFAULT=1
while getopts t:u:p:e: opt; do
	case $opt in
	t)
		tickets=$OPTARG
		;;
	u)
		user=$OPTARG
		;;
	p)
		passfile=$OPTARG
		source $passfile
		;;
	e)
		event=$OPTARG
		;;
	esac
done


# login to raven and save cookie
wget --keep-session-cookies --save-cookies cookies.txt --post-data 'userid='$user'&pwd='$passpwd'&submit' https://raven.cam.ac.uk/auth/authenticate2.html
rm authenticate2*

#read event list
#TODO: ADD specificity for  any event
wget --load-cookies cookies.txt http://mcr.clare.cam.ac.uk/events -O events.html

url=$(grep "$event" events.html | grep -E '[0-9][0-9][0-9]' -o)

newurl="http://mcr.clare.cam.ac.uk/events/mealbooker.py/bookEventHandler/$url"
queueurl="http://mcr.clare.cam.ac.uk/events/mealbooker.py/joinQueueForEventHandler/$url"

echo "newurl=$newurl" > EVENTINFO
echo "queueurl=$queueurl" >> EVENTINFO
echo "tickets=$tickets" >> EVENTINFO
