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
optparse.define short=i long=input desc="Input file" variable=input


source $( optparse.build )
################################
#  Required args and validations
################################
# if [ "$required" == "" ]; then
#     echo "Error: no input provided with -r|--required" 1>&2
#     exit 1
# fi
# Does file exist?
if [ ! -f $input ]; then
    echo "File doesn't exist at provided path: '$input'" 1>&2
    exit 1
fi




# if [ "$optional" == ""]; then
#     echo "Error: no value provided with -o|--optional"
# fi
################################
# No options: --help
################################
if [ $# -eq 0 ]; then
    echo "Usage: lines_per_file.sh [-i|--input INPUT]" >2
    echo "Options:" >2
    echo "        -?|--help" >2
    exit 1
fi







#####################################

#      M a i n

#####################################


# Perl
# Perl one liner guide
# Marcel Grunauer
# https://blogs.perl.org/users/marcel_grunauer/2010/12/one-liner-to-count-the-number-of-lines-in-a-file.html

# AFAICT $. is the current line number
# -n invokes once per line
# -E is like -e but allows special features
# so -e is just the switch for a one-liner as string at the CLI
# say is somewhat equivalent to print or printf, or ruby puts
# }{ is the secret sauce, Marcel on the perl blog says
# until $_ is undefined, loop
# Then print the $. line number.


#perl -nE '}{say$.' $input

# awk
# https://unix.stackexchange.com/questions/362278/how-to-use-awk-to-count-the-total-number-of-input-lines-in-a-file
# User User455555009
# NR is the awk var that contains the current line of the file


#awk 'END{print NR}' $input

# sed
# https://www.baeldung.com/linux/bash-count-lines-in-file
# sed -n '=' $input
# prints each line number
# so '=' is the line number
# $ in sed means 'end of' loosely...



#sed -n '$=' $input


# And finally:
wc -l $input
