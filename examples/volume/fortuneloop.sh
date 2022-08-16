#!/bin/bash

trap "exit" SIGINT
mkdir /var/htdocs
#interval=${1:-5}
interval=${INTERVAL:-5}

while :
do
	echo $(date +"%Y-%m-%d %H:%M:%S") Writing fortune to /var/htdocs/index.html
	/games/fortune > /var/htdocs/index.html
	sleep $interval
done
