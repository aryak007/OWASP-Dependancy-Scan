#!/bin/bash +x
#WORKSPACE = "$1"

SAVEIFS=$IFS

IFS=',' read -ra ADDR <<< "$1"
for i in "${ADDR[@]}"; do
    echo $(i)
done

IFS=$SAVEIFS
#echo -e "\033[31m These files should not be checked in to your code \033[0m"