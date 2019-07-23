#!/bin/bash
SERVER_ALIAS=$1;
FOLDER_DIR=$(pwd)

ip=$(grep $SERVER_ALIAS'.local' /etc/hosts | awk '{print $1}')
if [ "$ip" != "127.0.0.1" ]
then
    sudo -- sh -c "echo 127.0.0.1    $SERVER_ALIAS.local >> /etc/hosts"
fi
cp $NGINX_EXAMPLE_FILE $NGINX_DEST$SERVER_ALIAS.conf

sed -i '' "s/SERVER_ALIAS/$SERVER_ALIAS.local/" $NGINX_DEST$SERVER_ALIAS.conf
sed -i '' "s#FOLDER_DIR#$FOLDER_DIR#" $NGINX_DEST$SERVER_ALIAS.conf

nginx -s reload
