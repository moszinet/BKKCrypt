#!/bin/bash
# Unit tests for BKKCrypt bash implementation
# USAGE: ./bkkcrypt_test.sh
null=

declare -a passwords=(null 
                      "alma" 
                      "!#$%!#$%!" 
                      "veryveryveryveryveryveryveryveryveryveryveryveryveryveryveryveryveryverylongpassword")    
declare -a failed=()

for plain in "${passwords[@]}" 
do
    encrypted=$(sh ./bkkcrypt.sh "$plain")    
    if [ "$plain" != "$encrypted" ]
    then
        failed+=($plain)    
    fi
done

if [ ${#failed[@]} -eq 0 ]; 
then
    echo "Pass"
else
    for fail in "${failed[@]}"
    do
        echo "Failed for '$fail'"
    done
fi
