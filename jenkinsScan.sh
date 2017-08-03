#!/bin/bash +x
#WORKSPACE = "$1"
FILES=$(find "$WORKSPACE" -type f ! -name "gradle-wrapper.jar" -name "*.jar" -o -name "*.aar" -o -name "*.zip" -o -name "*.rar" -o -name "*.tar" -o -name "*.gzip" -o -name "*.exe" -o -name "*.dmg" -o -name "*.zip" -o -name "*.apk" -o -name "*.ipa" -o -name "*.dll" -o -name "*.pyc")

for file in $FILES; do
	fileName=$(basename $file)
	notPermittedFilesList="$notPermittedFilesList \033[31m $fileName \033[0m \n"
	notPermittedExtensionPresent=1
done;

if [[ $notPermittedExtensionPresent -eq 1 ]]
then
	echo " ------------ The following files are not permitted!!!! ------------"
	echo -e "$notPermittedFilesList"
fi

#echo -e "\033[31m These files should not be checked in to your code \033[0m"