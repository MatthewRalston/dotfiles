#!/bin/bash
set -e


source /home/matt/home/etc/optparse/optparse.bash
# Author: Matt Ralston
# Date: 1/22/24
# Description:
# This is a template script containing options parsing

VERSION=0.0.1


################################

#  OptParse | Options

################################
optparse.define short=n long=num desc="Repeat the command n times" variable=n
optparse.define short=c long=command desc="String to exec" variable=command



source $( optparse.build )
################################
#  Required args and validations
################################

executable=$(echo "$command" | cut -d' ' -f1)


which $executable 1>/dev/null
exitstatus=$?
if [ "$exitstatus" == "0" ]
then
    echo
    echo
    echo "executable was properly located in user path..." 1>&2
    echo
else
    echo "could not locate script/executable in user path..." 1>&2
    exit 1
fi



################################
# No options: --help
################################
if [ $# -eq 0 ]; then
    echo "Usage: timeme.sh [-n|--num N] [-c|--command COMMAND]" 1>&2
    echo "Options:" 1>&2
    echo "        -?|--help" 1>&2
    exit 1
fi







#####################################

#      M a i n

#####################################

for i in $(seq 1 $n)
do
    /usr/bin/time -a -o timeme.tsv -f "$i\t%E" $command
done

