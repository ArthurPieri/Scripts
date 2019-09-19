#! /bin/bash

MY_SHELL="bash"
##To create a test use []
if [ "$MY_SHELL" = "bash" ]
then
##Comands
echo "You seem to like the bash shell"
elif [ "$MY_SHELL" = "csh" ]
then
echo "You seem to like the csh shell"
##Elif precisa ser acompanhado do 'then'
##Else if
else
echo "You seem to like windows"
##Else nao precisa de then
##Else sempre precisa estar no final
##Comands if false
fi
##Sempre terminar o bloco inteiro de IF com FI
