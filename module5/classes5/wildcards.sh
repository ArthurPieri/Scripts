#! /bin/bash
#----------------------------------------------------------------------------------------
#A character or string used for pattern matching
#Globbing expands the wildcard pattern into a list of files and/or directories (paths)
# The two main characters are: * and ?
# using * matches zero or more characters
# using ? matches exactly one character
#---------------------------------------------------------------------------------------
# [] a character class -> Matches any of the characters included between the brackets
# Matches exactly one character
# Exemple: ca[nt]* will return: can, cat, candy, catch and etc
#---------------------------------------------------------------------------------------
# [!] excludes the caracters in the brackets
# [a-g]* Use two characters separated by a hyphen to create a range in a character class
# [[:alpha:]] alfabetic letters
# [[:alnum:]] leters or decimals
# [[:digit:]] numbers 0 to 9
# [[:lower:]] lower case letters 
# [[:space:]] spaces, new lines and etc
# [[:upper:]] upper case letters
#---------------------------------------------------------------------------------------
# You can exclude the wild card with \ like *\?
#---------------------------------------------------------------------------------------
# *
# ?
# []
# [0-3] or [a-g]
# [[:digit:]]
#---------------------------------------------------------------------------------------

for FILE in /var/www/*.html
do 
    echo "Copying ${FILE}"
    cp ${FILE} /var/www-just-hhtml
done