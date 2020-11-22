#!/bin/bash

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

SERVER_ALIAS=$1;
FOLDER_DIR=$(pwd)

if [ "$SERVER_ALIAS" == "" ]
then
SERVER_ALIAS=$(echo "${PWD##*/}")
fi

check_host() {
    ip=$(grep $SERVER_ALIAS'.local' /etc/hosts | awk '{print $1}')
    if [ "$ip" == "127.0.0.1" ]
    then
        printf "${Red}It is already defined in /etc/hosts, Changing it to ${SERVER_ALIAS}_1 from ${SERVER_ALIAS}${Color_Off}\n"
        # Since `read` is not working along with Process function for user input.
        SERVER_ALIAS=${SERVER_ALIAS}_1
        check_host
    else
        sudo -- sh -c "echo 127.0.0.1    $SERVER_ALIAS.local >> /etc/hosts"
    fi
   
}
# Checking the host in /etc/host file
check_host
cp $NGINX_EXAMPLE_FILE $NGINX_DEST$SERVER_ALIAS.conf

sed -i '' "s/SERVER_ALIAS/$SERVER_ALIAS.local/" $NGINX_DEST$SERVER_ALIAS.conf
sed -i '' "s#FOLDER_DIR#$FOLDER_DIR#" $NGINX_DEST$SERVER_ALIAS.conf

port=$(cat $NGINX_DEST$SERVER_ALIAS.conf | grep 'listen ' | awk '{print $2}')
port=$(echo $port | sed 's/.$//')

nginx -s reload

echo -e "${Yellow}Application is running at http://$SERVER_ALIAS.local:$port${Color_Off}" 