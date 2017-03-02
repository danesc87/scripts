#!/bin/bash
#Script to calculates verification sums on files using zenity to display options, errors and responses
if [ -d "$1" ]; then
zenity --title "Error" --info --text="Can not calculate sum from a directory"
else
sumType=$(zenity --height=230 --list --title "Type of Sum" --column Sumas "MD5" "SHA1" "SHA224" "SHA256" "SHA384" "SHA512")
if [ $sumType = "MD5" ]; then
zenity --title MD5 --info --text=`md5sum "$1"`
elif [ $sumType = "SHA1" ]; then
zenity --title SHA1 --info --text=`sha1sum "$1"`
elif [ $sumType = "SHA224" ]; then
zenity --title SHA224 --info --text=`sha224sum "$1"`
elif [ $sumType = "SHA256" ]; then
zenity --title SHA256 --info --text=`sha256sum "$1"`
elif [ $sumType = "SHA384" ]; then
zenity --title SHA384 --info --text=`sha384sum "$1"`
elif [ $sumType = "SHA512" ]; then
zenity --title SHA512 --info --text=`sha512sum "$1"`
else 
exit 0
fi
fi

