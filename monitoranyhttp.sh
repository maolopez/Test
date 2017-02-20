#!/bin/sh

location=$1

if  [ -z "$location" ]
then
         echo "please provide the location argument without http://"
         exit
fi

res=$(curl -s -L -I $location | grep HTTP/1.1 | awk '/HTTP\/1\.1\s(5[0-9][0-9])\s/ {count++} END{print count}')

if [ "$res" -ge "1" ]
then
          mkdir /home/user/scripts/$location
          cd /home/user/scripts/$location
          tries=$(($res+1))
          wget -d --tries=$tries http://$location -o log
          cat /home/user/scripts/$location/log | grep -i "error" | echo "ACTION REQUIRED: $location is down, check the logs." 
          exit
fi

echo "DONE! $res"
