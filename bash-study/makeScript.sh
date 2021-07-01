#! /bin/bash

filename="${PWD}/${1}.sh"
touch $filename
chmod u+x $filename
echo "#! /bin/bash" >> $filename
printf "%s script file is created.\n" "$filename"
