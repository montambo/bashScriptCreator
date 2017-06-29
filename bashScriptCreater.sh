#!/bin/bash        
#title        :bashScriptMaker
#description  :This will create the header for bash scripts for 
#author		  :Randy Montambo
#date         :20160508
#version      :0.1 (Alpha)    
#usage		  :./bashScriptCreator.sh
#==============================================================================

## Variables First
today=$(date +%Y-%m-%d)
name="Randy Montambo"
div=##################################################################################

## Find what dir it is going input
printf "What directory does this go in? "; read -r dir

## make sure last character is a slash
strLastChar=$((${#dir}-1))
if [[ "${strLastChar}" != "/" ]]
then
	dir=${dir}/
fi

## make sure the dir exists
if [ ! -d "${dir}" ] 
then
	printf "The directory doesnt exist please make it to continue"
	exit 1
fi

## Something new to learn
printf "Enter a title: " ; read -r title

## Remove the spaces from the title if necessary.
title=${title// /_}

## Convert uppercase to lowercase.
title=${title,,}

## Add .sh to the end of the title if it is not there already.
[ "${title: -3}" != '.sh' ] && title=${title}.sh

 # Check to see if the file exists already.
if [ -e $dir$title ] ; then 
printf "\n%s\n%s\n\n" "The script \"$title\" already exists." \
"Please select another title."
_select_title
fi

## lets set a file variable
strFile=$dir$title

## we will start making the file now
echo "#!/bin/bash " >> ${strFile}

## NEED TO DO SOME CLEAN UP BELOW

echo "##author:       ||"${name}  >> ${strFile}
echo "##date:         ||"${today}  >> ${strFile}
echo "##usage:        ||./"${title}  >> ${strFile}



printf "Enter a description: " ; read -r dscrpt

## I would like to be able to set certain widths but I do not want to limit the input that I enter
## so a simple fix would be to echo it to the file and then work with it to make th ebash script.

echo ${dscrpt} | fold -s -w 54  >> $date"tmpfold.txt"

while read strLine
do	
	echo "##description:  ||$strLine" >> ${strFile}
done < $date"tmpfold.txt"

## remove our temp file
rm $date"tmpfold.txt"

## echo our div
echo ${div} >> ${strFile}

# Make the file executable.
chmod +x ${strFile}


