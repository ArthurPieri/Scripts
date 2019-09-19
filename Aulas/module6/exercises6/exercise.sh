#! /bin/bash

case "${1}" in
    start)
        /usr/bin/sshd
        ;;
    stop)
        kill $(cat /var/run/sshd.pid)
        ;;
    *)
        echo "Usage: $0 is: ( start|stop )" 
        exit 1
        ;;
esac

#Nao vou fazer o resto, pq nao entendi o que tem que ser feito