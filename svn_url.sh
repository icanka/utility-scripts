#!/bin/bash

# Parse version text file and construct an svn url
# Ex:
# pkg_name1 2.45
# pkg_name2 1.2.13

svn_url_temp="https://rota/gamsys/gamsys.src/test/ml/pkg_name/version"

input="/home/raflman/Desktop/test.txt"
while IFS= read -r line
do
    pkg_array=($line)
    
    svn_url="${svn_url_temp/pkg_name/"${pkg_array[0]}"}"
    svn_url="${svn_url/version/"${pkg_array[1]}"}"
    echo $svn_url
done < "$input"