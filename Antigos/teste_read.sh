#! /bin/bash

echo Did you run createuser.sh script first?
read -p "Are you sure? (y or n): " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

echo YEXX