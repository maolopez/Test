#!/bin/sh

location=$1

if  [ -z "$location" ]
then
         echo "please provide the location argument without http://"
         exit
fi

res=`curl -s -L -I $location | grep HTTP/1.1 | awk '/50*/ {count++} END{print count}'`

if [ "$res" -ge "1" ]
then
mkdir /home/user/scripts/$location
cd /home/user/scripts/$location
tries=$(($res+1))
wget -d --tries=$tries http://$location -o log
cat /home/user/scripts/$location | grep -i "error" | echo "ACTION REQUIRED: $location is down, check the logs." 
fi

echo "DONE! $res"
