#! /bin/bash

#Functions, can be used in the same way as others programming languages
#I'll start all the functions with 'f_' so there are no mistakes with variables

function f_hello() {
    echo "Hello!"
    f_now
}
function f_now() {
    echo "It's $(date)"
}

f_hello