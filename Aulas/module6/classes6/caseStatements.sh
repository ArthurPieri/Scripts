# /bin/bash

#How to create a case statmente
#case "${VAR}" in
#    pattern_1)
#        # Commands go here
#        ;;
#    pattern_N)
#        # Commands go here
#        ;;
#esac

# Start and Stop a Script example
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