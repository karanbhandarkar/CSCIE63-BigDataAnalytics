#!/bin/bash

if [ -z "$1" ]; then
        echo "Missing output folder name"
        exit 1
fi

split -l 10000 orders.txt chunk

for f in `ls chunk*`; do
        if [ "$2" == "local" ]; then
                mv $f $1/staging
		sleep 3
		mv $1/staging/$f $1/input/
		rm -f $f
        else
                hadoop fs -put $f /user/cloudera/staging
                sleep 3 
                hadoop fs -mv /user/cloudera/staging/$f /user/cloudera/$1/
                rm -f $f
        fi
done
