#!/bin/bash
#Script to calculates verification sums on files using kdialog to display options, errors and responses
if [ -d "$1" ]; then
  kdialog --title "Error" --error "Can not calculate sum from a directory"
else
  choice=$(kdialog --menu "Type of Sum" 1 "MD5" 2 "SHA1" 3 "SHA224" 4 "SHA256" 5 "SHA384" 6 "SHA512")
    for sumType in $choice
      do
        if [ $sumType = 1 ]; then
          kdialog --title "MD5" --msgbox `md5sum "$1"`
        elif [ $sumType = 2 ]; then
          kdialog --title "SHA1" --msgbox `sha1sum "$1"`
        elif [ $sumType = 3 ]; then
          kdialog --title "SHA224" --msgbox `sha224sum "$1"`
        elif [ $sumType = 4 ]; then
          kdialog --title "SHA256" --msgbox `sha256sum "$1"`
        elif [ $sumType = 5 ]; then
          kdialog --title "SHA384" --msgbox `sha384sum "$1"`
        elif [ $sumType = 6 ]; then
          kdialog --title "SHA512" --msgbox `sha512sum "$1"`
        else
          exit 0
        fi
      done
fi
