#! /bin/bash

# You can add math operetaros inside (())
# VAR=0 -> ((VAR++)) -> echo VAR

#Using Math operators
VAR=1
((VAR++))
echo ${VAR}
# It can be useful inside loop variables

#Loops are created using 'while'
while [ "${CORRECT}" != "y" ]
    do
        read -p "Enter your name: " NAME
        read -p "Is ${NAME} correct? " CORRECT
done

#You can exit a while loop using break
# break will stop the loop but not the script
# To restart the loop use the continue statement