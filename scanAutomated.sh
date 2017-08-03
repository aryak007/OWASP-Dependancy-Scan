#!/bin/bash +x
#WORKSPACE = "$1"

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

#find DockerWorkItems-1 -type f \( -name "*.jar" -o -name "*.aar" -o -name "*.zip" -o -name "*.rar" -o -name "*.tar" -o -name "*.gzip" -o -name "*.exe" -o -name "*.dmg" -o -name "*.zip" -o -name "*.apk" -o -name "*.ipa" -o -name "*.dll" -o -name "*.pyc" -o -name "*.gem" \)  \( ! -name "gradle-wrapper.jar" ! -name "xyz.zip" \)
FILES=$(eval $1)
count=0

for file in $FILES; do
	fileName=${file##*/}
	if [[ $count -eq 0 ]]
	then
		notPermittedFilesList="$notPermittedFilesList$fileName"
	else
		notPermittedFilesList="$notPermittedFilesList,$fileName"
	fi
	count=$((count+1))

	notPermittedExtensionPresent=1
done;


if [[ $notPermittedExtensionPresent -eq 1 ]]
then
	echo " ------------ The following files are not permitted!!!! ------------"
	echo  -e "$notPermittedFilesList" 
	echo NOT_PERMITTED_FILES_PRESENT="Y" > env.properties
	echo NOT_PERMITTED_FILES_LIST="$notPermittedFilesList" >> env.properties
else
	echo NOT_PERMITTED_FILES_PRESENT="N" > env.properties
fi

IFS=$SAVEIFS
#echo -e "\033[31m These files should not be checked in to your code \033[0m"