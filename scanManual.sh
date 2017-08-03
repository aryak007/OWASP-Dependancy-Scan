#!/bin/bash +x
#WORKSPACE = "$1"

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")


#find DockerWorkItems-1 -type f \( -name "*.jar" -o -name "*.aar" -o -name "*.zip" -o -name "*.rar" -o -name "*.tar" -o -name "*.gzip" -o -name "*.exe" -o -name "*.dmg" -o -name "*.zip" -o -name "*.apk" -o -name "*.ipa" -o -name "*.dll" -o -name "*.pyc" -o -name "*.gem" \)  \( ! -name "gradle-wrapper.jar" ! -name "xyz.zip" \)
FILES=$(eval $1)
emailBody="Hi,<br><br>As part of our effort to make software development and delivery processes at par with the recommended security standards, we are implementing recommendations based on OWASP ASVS guidelines. One of the requirements [<a href = "http://owasp-aasvs.readthedocs.io/en/latest/requirement-1.1.html">OWASP ASVS v1.1</a>] of the guideline is to ensure that we understand and regularly keep a track of components in our codebase.<br><br>According to OWASP v1.1, all application components must be identified and must be known to be needed.<br><br>To ensure the above, we have implemented checks to filter out/block libraries which do not abide by the above mentioned guidelines. The impacts of this restriction are:<br>1. Any 3rd party or in-house library is not allowed to be checked in along with your code.<br>2. If any such library is already checked in, a periodic scan will detect and send a mail with the names of the libraries.<br><br>.If you are getting this mail, it’s likely that one or more of libraries/files/other components in your codebase are impacted for your repository <a href=$3>$1</a>. These files are listed below:<br><br>"
count=0
for file in $FILES; do
	fileName=${file##*/}
	notPermittedFilesList="$notPermittedFilesList \033[31m $fileName \033[0m \n"
	count=$((count+1))
	emailBody="$emailBody $count. <b>$fileName</b></ul> <br>"
	notPermittedExtensionPresent=1
done;

emailBody="$emailBody <br><b><i>If you have any questions or if you think some or all of the components are necessary for your project, please get in touch with EPI team to put them in the excluded list for this check.</b></i> <br><br><b>Thanks<br>Team EPI</b>"

if [[ $notPermittedExtensionPresent -eq 1 ]]
then
	echo " ------------ The following files are not permitted!!!! ------------"
	echo  -e "$notPermittedFilesList"
	echo IS_SEND_MAIL="true" > env.properties
	echo SUBJECT="OWASP File Extensions Scan Report" >> env.properties
	echo RECIPIENT="$2" >> env.properties
	echo BODY="$emailBody" >> env.properties

else
	echo IS_SEND_MAIL="false" > env.properties
	
fi

IFS=$SAVEIFS
#echo -e "\033[31m These files should not be checked in to your code \033[0m"