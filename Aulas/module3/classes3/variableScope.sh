#! /bin/bash

#By default all variables are global
#Variables have to be defined before used
#IF a variable is declared in a function it only becomes available after the function is called

f_function() {
    GLOBAL_VAR=1
}

#GLOBAL_VAR not available yet.
echo "It should Print nothing here: ${GLOBAL_VAR}"
#function is called here:
f_function
#GLOBAL_VAR is NOW available
echo "It should Printi '1' here: ${GLOBAL_VAR}"

#You can use local variables also, just create the variable withing the function with 'local' keyword
f_function2() {
    local LOCAL_VAR=1
}

#GLOBAL_VAR not available.
echo "It should Print nothing here: ${LOCAL_VAR}"
#function is called here:
f_function2
#GLOBAL_VAR still not available.
echo "It should still Print nothing here: ${LOCAL_VAR}"
