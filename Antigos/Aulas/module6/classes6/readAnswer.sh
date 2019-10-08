#! /bin/bash

read -p "Enter y or n: " ANSWER
case "${ANSWER}" in
    [yY]|[yY][eE][sS])
        echo "You answered '${ANSWER}' that is a yes."
        exit 0
        ;;
    [nN]|[nN][oO])
        echo "You answered '${ANSWER}' that is a no."
        exit 0
        ;;
    *)
        echo "You answered '${ANSWER}' that is a anvalid answer"
        echo "Please respond with Y or N"
        exit 1
        ;;
esac