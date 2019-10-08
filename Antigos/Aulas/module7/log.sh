#! /bin/bash

#Functions Declaration
#Remember that i'll always use f_ un the function name
# the command is logger

f_logit () {
    local LOG_LEVEL=${1}
    shift
    MSG=${@}
    TIMESTAMP=$(date +"%Y-%m-%d %T")

    if [ ${LOG_LEVEL} = 'ERROR' ] || ${VERBOSE}
    then
        echo -s "${TIMESTAMP} ${HOST} ${PROGRAM_NAME}[${PID}]: ${LOG_LEVEL} ${MSG}"
    fi
}