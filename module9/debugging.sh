#! /bin/bash

# if use -x after the Shebang it prints every command
# You can use 'set -x' anywhere and to stop use 'set +x'
set -x
TEST_VAR="test"
echo "${TEST_VAR}"
set +x

# '-e' exit on error and can be combined with other options like '-x'
#set -e
FILE_NAME="/not/here"
ls ${FILE_NAME}
echo ${FILE_NAME}
#set +e
echo "Joseee"

# -v = Prints shell input lines as they are read
# can still be used in conjuction
set -v -x
TEST_VAR2="VERBOSE TESTE"
echo "${TEST_VAR2}"
set +v +x

#More commands on help -> run 'help set|less' to simplify