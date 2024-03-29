#!/bin/bash


export GITMODE=$HOME/.gitmode
HELP=0
UNSET=0
START=0
if [[ $# > 0 ]]
then
    key="$1"
    case $key in
	-h|--help)
	HELP=1
	;;

	-u|--unset)
	UNSET=1
	;;

	-s|--start)
	START=1
	;;

    esac
    shift
fi

if [ $HELP == 1 ];then
    echo "Usage:"
    echo "     gitmode [-s|--start] [-u|unset]"
    echo "Options:"
    echo "  -s|--start  Echo a PS1 which will show version control information in terminal prompt"
    echo "  -u|--unset  Echo a PS1 which will NOT show version control information in terminal prompt"
    exit 2
fi


gitmode="\[${COLOR_RED}\][\[${UC}\]\u@\h\[${COLOR_RED}\]] \[${COLOR_LIGHT_GRAY}\]\$(vcprompt)\[${COLOR_LIGHT_GREEN}\]\$(vcprompt -f %a)\[${COLOR_RED}\]\$(vcprompt -f %m) \[${COLOR_RED}\]<\[${COLOR_LIGHT_CYAN}\]\w\[${COLOR_RED}\]>\[${COLOR_LIGHT_GREEN}\]>"
speedmode="\[${UC}\]\u@\h \[${COLOR_LIGHT_CYAN}\]\w>"


if [[ $UNSET == 1 ]]; then
    if [[ -e $GITMODE ]]; then
	rm $GITMODE
    fi
elif [[ $START == 1 ]]; then
    if [ ! -e $GITMODE ]
    then
	touch $GITMODE
    fi
fi

if [[ -e $GITMODE ]]; then
    #echo gitmode active
    echo $gitmode
elif [[ ! -e $GITMODE ]]; then
    #echo gitmode inactive
    echo $speedmode
fi

