#! /bin/bash

read -p "Enter y or n: " ANSWER
case "${ANSWER}" in
    [yY]*|[sS][iI][mM]*)
        echo "You answered '${ANSWER}' wich we understood as a 'YES'"
        exit 0
        ;;
    [nN]*)
        echo "You answered '${ANSWER}' wich we understood as a 'NO'"
        exit 0
        ;;
    *)
        echo "You answered '${ANSWER}' wich is an invalid answer"
        echo "Please respond with 'Y' or 'N'"
        exit 1
        ;;
esac

