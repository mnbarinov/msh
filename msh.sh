#!/bin/bash
#########################################
## * * * * * * * * * * * * * * * * * * ##
## * Bash Minicom Style SSH Manager  * ##
## * Mikhail Barinov dev@mbarinov.ru * ##
## * Version 1.0.1 05.05.2022        * ##
## * * * * * * * * * * * * * * * * * * ##
#########################################
clear
selectssh(){
    hosts_arr=( $(cat ~/.ssh/config | grep -P "Host\s[a-zA-Z0-9]{1,}" | cut -d " " -f 2) );
    bold=$(tput bold);
    normal=$(tput sgr0);
    arraylength=${#hosts_arr[@]};
    echo -e "\v${bold}Please select which Host to use SSH with:\v";
    echo "Existing SSH [pre]sets:${normal}";
    for (( i=1; i<=${arraylength}; i++ ));
    do
        echo -e "[$i]:\t${hosts_arr[$i-1]}";
    done
    echo -e "\v"
    read -e -p "Please select a valid host number (from 1 to ${arraylength})> " NUM
    hnum=( $(echo $NUM | egrep -oh "[0-9]{1,}") );
    if [[ $hnum -gt 0 ]] && [[ $hnum -le ${arraylength} ]];
    then
        clear;
        echo -e "${bold}Host:\t${hosts_arr[$hnum-1]}${normal}";
        ssh ${hosts_arr[$hnum -1]};
    else
        selectssh;
    fi
}
selectssh;
