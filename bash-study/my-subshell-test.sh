#! /bin/sh


(
# Inside parentheses, and therefore a subshell...
while [ 1 ]
do
	sleep 1
	echo $BASHPID
done
)
