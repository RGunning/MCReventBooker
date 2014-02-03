#!/bin/bash

source EVENTINFO

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