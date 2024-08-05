#!/usr/bin/env bash
################################################
# Created by Alex M. Schapelle AKA silent-mobius
# Purpose: buils script for making this project work
# Version: 0.0.1
# Date: 14.06.2024
#################################################
PROJECT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# APP_VERSION=${1:- 'latest'}
NULL=/dev/null


function main(){
if [[ $EUID != 0 ]];then
    note "warn" "Please elevate your privileges"
else
    if which docker > $NULL 2>&1;then
        docker compose build 
    else
        note "warn" "Missing docker on the system: Please run 'curl -L get.docker.com |sudo bash' to fix this"
    fi
fi
}

function note(){
    LEVEL="${1^^}"
    MSG="$2"
        if [[ $LEVEL == 'WARN' ]];then
            SYMBOL='!'
        else
            SYMBOL='+'
        fi
    printf "[$SYMBOL] %s:\t%s\n" "$LEVEL" "$MSG" 
}

######
# Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _
######
main "$@"