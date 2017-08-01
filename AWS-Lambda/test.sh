#!/usr/bin/env bash 

set -e

echo Encryption check
[ $(curl -s https://jpimbi6jr2.execute-api.us-east-1.amazonaws.com/prod/BKKCrypt\?password\=helloka) = helloka ]

echo Checking for edge cases
[ -z $(curl -s https://jpimbi6jr2.execute-api.us-east-1.amazonaws.com/prod/BKKCrypt) ]

echo "All good! :)"