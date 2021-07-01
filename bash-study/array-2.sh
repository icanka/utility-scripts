#! /bin/bash

# array-2: Use arrays to tally file owners

declare -A files file_group file_owner groups owners

if [[ ! -d "$1" ]]; then
	echo "Usage: array-2 dir" >&2
	exit 1
else
	if [[ -z $(ls "$1") ]]; then
		echo "$1: Directory empty"
		exit 2
	fi
fi

for i in "$1"/*; do
	

	owner="$(stat -c %U "$i")"
	group="$(stat -c %G "$i")"
	
	files["$i"]="$i"
	file_owner["$i"]="$owner"
	file_group["$i"]="$group"
	((++owners[$owner]))
	((++groups[$group]))
done


{ for i in "${files[@]}"; do

	printf "%-40s %-10s %-10s\n" \
	"$i" "${file_owner["$i"]}" "${file_group["$i"]}"

done } | sort

echo "List owners:"

{ for i in "${!owners[@]}"; do
	printf "%-10s: %5d file(s)\n" "$i" "${owners["$i"]}"
done } | sort




echo -----------------------------------------------------------

array=("izzet can" "emre karagoz" "bunyamin aktas")


# Take care for quoated or unquoated expansions
# Note: unqoted expansions will get evaluated.
# For ex: "echo hello        world" will print
# "hello world", for to print it with all the
# white spaces, quote the parameter.

##########################################
# Syntax  |         Effective Result     |
##########|##############################|
#   $*    |    $1   $2   $3  ...   $N	 |
##########|##############################|
#   $@    |    $1   $2   $3  ...   $N    |
##########|##############################|	
#  "$*"   |      "$1c$2c$3c...c$N"       |
##########|##############################|
#  "$@"   |   "$1" "$2" "$3" ...  "$N"   |
##########################################


# array=("izzet can" "emre karagoz" "bunyamin aktas")

#  ${array["$i"]}
# "${array["$i"]}"
# "${array["$i"]}"


# for i in izzet can emre karagoz bunyamin aktas; do
# 	echo "$i"
# done

# for i in "izzet can emre karagoz bunyamin aktas"; do
# 	echo "$i"
# done

# for i in "izzet can" "emre karagoz" "bunyamin aktas"; do
# 	echo "$i"
# done


