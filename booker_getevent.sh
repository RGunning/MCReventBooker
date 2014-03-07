#!/bin/bash
sage()
{
cat << EOF
usage: $0 options

This script finds and books Clare College MCR Formal Dinners based on supplied options

OPTIONS:
   -h      Show this message
   -t      number of tickets '1' or '2'
   -u      raven username
   -p      file password is stored in
   -e      event name
EOF
}

tickets=1
user='rjg70'
event="MCR Formal"

# read number of tickets required from command line. DEFAULT=1
while getopts ht::u::p:e:: opt; do
	case $opt in
	h)
             	usage
             	exit 1
             	;;
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
	?)
        	usage
                exit
                ;;
	esac
done

if [[ -z $tickets ]] || [[ -z $user ]] || [[ -z $password ]] || [[ -z $event ]]
then
     usage
     exit 1
fi


# login to raven and save cookie
wget --keep-session-cookies --save-cookies cookies.txt --post-data 'userid='$user'&pwd='$passpwd'&submit' https://raven.cam.ac.uk/auth/authenticate2.html
rm authenticate2*

#read event list
#TODO: ADD specificity for  any event
wget --load-cookies cookies.txt http://mcr.clare.cam.ac.uk/events -O events.html

url=$(grep -i "$event" events.html | grep -E '[0-9][0-9][0-9]' -o)

newurl="http://mcr.clare.cam.ac.uk/events/mealbooker.py/bookEventHandler/$url"
queueurl="http://mcr.clare.cam.ac.uk/events/mealbooker.py/joinQueueForEventHandler/$url"

echo "newurl=$newurl" > EVENTINFO
echo "queueurl=$queueurl" >> EVENTINFO
echo "tickets=$tickets" >> EVENTINFO
