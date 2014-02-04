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

#read event list
#TODO: ADD specificity for  any event
wget --load-cookies cookies.txt http://mcr.clare.cam.ac.uk/events -O events.html

url=$(grep -i "$event" events.html | grep -E '[0-9][0-9][0-9]' -o)
join=$(< events.html tr -d '\n' | grep -oP '(?<=<p> ).*?(?= </p>)'| grep $url -o | wc -w)
echo $url
echo $join

#if event not found retry up to 20 times
counter=0
echo "run through"
echo $counter

while [[ $join == 1 && $counter != 20 ]]; do
	wget --load-cookies cookies.txt http://mcr.clare.cam.ac.uk/events -O events.html
	url=$(grep -i "$event" events.html | grep -E '[0-9][0-9][0-9]' -o)
	join=$(< events.html tr -d '\n' | grep -oP '(?<=<p> ).*?(?= </p>)'| grep $url -o | wc -w)
	echo $join
	echo "Run through ="
	echo $counter
	let counter=counter+1
done

newurl="http://mcr.clare.cam.ac.uk/events/mealbooker.py/bookEventHandler/$url"
queueurl="http://mcr.clare.cam.ac.uk/events/mealbooker.py/joinQueueForEventHandler/$url"
echo $newurl
echo $queueurl


#curl --cookie cookies.txt https://mcr.clare.cam.ac.uk/events -o out
#wget --load-cookies cookies.txt --post-data 'numTickets=1&submit' $newurl
#wget --load-cookies cookies.txt --no-check-certificate --post-data 'numTickets=1&submit' $newurl
#curl --cookie cookies.txt -d 'numTickets=1&submit' --location "http://mcr.clare.cam.ac.uk/events/mealbooker.py/joinQueueForEventHandler/242"


curl $newurl -H 'Origin: http://mcr.clare.cam.ac.uk' \
	-H 'Accept-Encoding: gzip,deflate,sdch' \
	-H 'Host: mcr.clare.cam.ac.uk' \
	-H 'Accept-Language: en-US,en;q=0.8,en-GB;q=0.6' \
	-H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.114 Safari/537.36' \
	-H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' \
	-H 'Referer: http://mcr.clare.cam.ac.uk/events/mealbooker.py/bookEvent/$url' \
	-H 'Cookie: alvis-internal-admin-cam-ac-uk-8080-PORTAL-PSJSESSIONID=Wd4vSpnhGxQVQvmrG25XvH33f0TDhPCH!-183770396; UcTemplate-CS_PROD=eyJBcHBOYW1lIjoiR1NTIn0=; __utma=221668106.906365725.1380882775.1381918620.1382196509.3; __utmc=221668106; __utmz=221668106.1382196509.3.2.utmccn=(organic)|utmcsr=google|utmctr=crsid+lookup|utmcmd=organic; __utma=125177048.956110093.1380651618.1382197744.1382434702.9; __utmc=125177048; __utmz=125177048.1382434702.9.8.utmcsr=google|utmccn=(organic)|utmcmd=organic|utmctr=(not%20provided); session="AMYSWkdusdN/03ZxEZI2rIRKSA8=?confirmProceedPressed=STAxCi4=&logged_in=STAxCi4=&user=Y2NvcHlfcmVnCl9yZWNvbnN0cnVjdG9yCnAxCihjZGF0YXR5cGVzClJhdmVuVXNlcgpwMgpjX19idWlsdGluX18Kb2JqZWN0CnAzCk50UnA0CihkcDUKUydpc0Fzc29jaWF0ZU1lbWJlcicKcDYKTDBMCnNTJ3VzZXJJRCcKcDcKUydyamc3MCcKcDgKc1MnaXNDUkEnCnA5CkwwTApzUydpc0FkbWluJwpwMTAKTDBMCnNTJ2lzTm9uQ2xhcmVBc3NvY2lhdGVNZW1iZXInCnAxMQpMMEwKc1MnaXNNQ1JNZW1iZXInCnAxMgpMMUwKc2Iu"; Ucam-WebAuth-Session=Not-authenticated' \
	-H 'Connection: keep-alive' \
	--cookie cookies.txt \
	--data 'numTickets='$tickets \
	--compressed

curl $queueurl -H 'Origin: http://mcr.clare.cam.ac.uk' \
	-H 'Accept-Encoding: gzip,deflate,sdch' \
	-H 'Host: mcr.clare.cam.ac.uk' \
	-H 'Accept-Language: en-US,en;q=0.8,en-GB;q=0.6' \
	-H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.114 Safari/537.36' \
	-H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' \
	-H 'Cookie: alvis-internal-admin-cam-ac-uk-8080-PORTAL-PSJSESSIONID=Wd4vSpnhGxQVQvmrG25XvH33f0TDhPCH!-183770396; UcTemplate-CS_PROD=eyJBcHBOYW1lIjoiR1NTIn0=; __utma=221668106.906365725.1380882775.1381918620.1382196509.3; __utmc=221668106; __utmz=221668106.1382196509.3.2.utmccn=(organic)|utmcsr=google|utmctr=crsid+lookup|utmcmd=organic; __utma=125177048.956110093.1380651618.1382197744.1382434702.9; __utmc=125177048; __utmz=125177048.1382434702.9.8.utmcsr=google|utmccn=(organic)|utmcmd=organic|utmctr=(not%20provided); session="AMYSWkdusdN/03ZxEZI2rIRKSA8=?confirmProceedPressed=STAxCi4=&logged_in=STAxCi4=&user=Y2NvcHlfcmVnCl9yZWNvbnN0cnVjdG9yCnAxCihjZGF0YXR5cGVzClJhdmVuVXNlcgpwMgpjX19idWlsdGluX18Kb2JqZWN0CnAzCk50UnA0CihkcDUKUydpc0Fzc29jaWF0ZU1lbWJlcicKcDYKTDBMCnNTJ3VzZXJJRCcKcDcKUydyamc3MCcKcDgKc1MnaXNDUkEnCnA5CkwwTApzUydpc0FkbWluJwpwMTAKTDBMCnNTJ2lzTm9uQ2xhcmVBc3NvY2lhdGVNZW1iZXInCnAxMQpMMEwKc1MnaXNNQ1JNZW1iZXInCnAxMgpMMUwKc2Iu"; Ucam-WebAuth-Session=Not-authenticated' \
	-H 'Connection: keep-alive' \
	--cookie cookies.txt \
	--data 'numTickets='$tickets \
	--compressed

#curl 'http://mcr.clare.cam.ac.uk/events/mealbooker.py/joinQueueForEventHandler/242'
#-H 'Origin: http://mcr.clare.cam.ac.uk' -H 'Accept-Encoding: gzip,deflate,sdch' 
#-H 'Host: mcr.clare.cam.ac.uk' -H 'Accept-Language: en-US,en;q=0.8,en-GB;q=0.6' 
#-H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.114 Safari/537.36' 
#-H 'Content-Type: application/x-www-form-urlencoded' 
#-H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' 
#-H 'Referer: http://mcr.clare.cam.ac.uk/events/mealbooker.py/joinQueueForEvent/242?numTickets=2&submit' 
#-H 'Cookie: alvis-internal-admin-cam-ac-uk-8080-PORTAL-PSJSESSIONID=Wd4vSpnhGxQVQvmrG25XvH33f0TDhPCH!-183770396; UcTemplate-CS_PROD=eyJBcHBOYW1lIjoiR1NTIn0=; __utma=221668106.906365725.1380882775.1381918620.1382196509.3; __utmc=221668106; __utmz=221668106.1382196509.3.2.utmccn=(organic)|utmcsr=google|utmctr=crsid+lookup|utmcmd=organic; __utma=125177048.956110093.1380651618.1382197744.1382434702.9; __utmc=125177048; __utmz=125177048.1382434702.9.8.utmcsr=google|utmccn=(organic)|utmcmd=organic|utmctr=(not%20provided); session="AMYSWkdusdN/03ZxEZI2rIRKSA8=?confirmProceedPressed=STAxCi4=&logged_in=STAxCi4=&user=Y2NvcHlfcmVnCl9yZWNvbnN0cnVjdG9yCnAxCihjZGF0YXR5cGVzClJhdmVuVXNlcgpwMgpjX19idWlsdGluX18Kb2JqZWN0CnAzCk50UnA0CihkcDUKUydpc0Fzc29jaWF0ZU1lbWJlcicKcDYKTDBMCnNTJ3VzZXJJRCcKcDcKUydyamc3MCcKcDgKc1MnaXNDUkEnCnA5CkwwTApzUydpc0FkbWluJwpwMTAKTDBMCnNTJ2lzTm9uQ2xhcmVBc3NvY2lhdGVNZW1iZXInCnAxMQpMMEwKc1MnaXNNQ1JNZW1iZXInCnAxMgpMMUwKc2Iu"; Ucam-WebAuth-Session=Not-authenticated' 
#-H 'Connection: keep-alive' 
#--data 'numTickets=2' 
#--compressed

rm authenticate*
#rm events*


