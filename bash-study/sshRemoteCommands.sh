#! /bin/bash

ssh -T centos-vps  <<- "ENDCON" 
	echo "$USER"
	echo "$HOSTNAME"
	echo "$PWD"
ENDCON
