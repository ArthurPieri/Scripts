#! /bin/bash

#I'll start all the functions with 'f_' so there are no mistakes with variables
#Functions Declarations
function f_backup_file () {
    if [ -f ${1} ]
    then
        BACK="/tmp/$(basename ${1}).$(date +%F).$$"
        echo "Backing up ${1} to ${BACK}"
        cp ${1} ${BACK}
    else
        echo "f_backup_file failed"
        return 1
    fi
}
f_backup_file /etc/hosts
if [ $? -eq 0 ]
then
    echo "Backup succeeded"
fi