#! /bin/bash

#I'll start all the functions with 'f_' so there are no mistakes with variables
#Functions Declarations
#--------------------------
function f_hello() {
    for NAME in $@
    do
        echo "Hello ${NAME}"
    done
}
#--------------------------

f_hello Arthur Jose Maria