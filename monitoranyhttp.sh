#!/bin/sh

location=$1

If  [ -z "$location" ]
then
         echo "please provide the location argument without http://"
         exit
fi

res=`curl -s -L -I $location | grep HTTP/1.1 | awk '/200/ {count++} END{print count}'`

if [ "$res" = "0" ]
then
mkdir /home/user/scripts/$location
cd /home/user/scripts/$location
tries=$(($res+1))
wget -drc --tries=$tries http://$location/ -o log
cat /home/user/scripts/$location | grep -i "error" | echo "ACTION REQUIRED: $location is down" 
fi

echo "DONE! $res"
