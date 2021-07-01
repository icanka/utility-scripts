#! /bin/bash

if test  -d $1 ; then
	echo "file exists"
fi

echo ---------------------

IFS="|"

for i in "/home/izzetcan"/*;do
	echo "$i"
	echo -------

done
