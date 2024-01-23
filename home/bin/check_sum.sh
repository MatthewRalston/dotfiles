#!/bin/bash
set -e


source /home/matt/home/etc/optparse/optparse.bash
# Author: Matt Ralston
# Date: 1/22/24
# Description:
# This is a shell script for validating downloaded file via sha256 checksum

VERSION=0.0.1


################################

#  OptParse | Options

################################
optparse.define short=f long=file desc="The file to validate" variable=FILE
optparse.define short=c long=checksum desc="Provided sha256 checksum" variable=CHECKSUM


source $( optparse.build )
################################
#  Required args and validations
################################
# if [ "$FILE" == "" ]; then
#     echo "Error: no input provided with -f|--file" 1>&2
#     exit 1
# fi
# Does file exist?
if [ ! -f $FILE ]; then
    echo "File doesn't exist at provided path: '$file'" 1>&2
    exit 1
fi




# if [ "$CHECKSUM" == ""]; then
#     echo "Error: no input provided with -c|--checksum" 1>&2
# fi
################################
# No options: --help
################################
if [ $# -eq 0 ]; then
    echo "Usage: check_sum.sh <-c|--checksum CHECKSUM> <-f|--file FILE>" 1>&2
    echo "Options:" 1>&2
    echo "        -h|--help" 1>&2
    exit 1
fi






#####################################

#      M a i n

#####################################

echo "Calculating checksum..." 1>&2
cs="$(sha256sum $FILE | cut -d' ' -f1)"
echo "complete." 1>&2

echo "sanity check" 1>&2
echo "Calculated: '$cs'" 1>&2
echo "Provided: '$CHECKSUM'" 1>&2



if [ "$cs" == "$CHECKSUM" ];
then
    echo "Checksums matched."
    echo "Calculated: '$cs'" 1>&2
    echo "Provided: '$CHECKSUM'" 1>&2
    exit 0
else
    echo "Error: file does not have correct checksum..." 1>&2
    echo "$cs" 1>&2
    exit 1
fi
