#################################################################
##################Sync one path to another#######################
#################################################################
rsync -avxHAX --info=progress2 / /new-disk/

The options are:

-a  : all files, with permissions, etc..
-v  : verbose, mention files
-x  : stay on one file system
-H  : preserve hard links (not included with -a)
-A  : preserve ACLs/permissions (not included with -a)
-X  : preserve extended attributes (not included with -a)
