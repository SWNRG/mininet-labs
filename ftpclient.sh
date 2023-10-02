#!/bin/bash

# Check if at least one argument is passed
if [ $# -eq 1 ]; then
    hostname=$1
else
    echo "Syntax: ./ftpclient.sh hostname"
    exit 1
fi

while true; do
  mkdir ~/tmp 2> /dev/null
  cd ~/tmp
  lftp -e 'get 512mb-file;exit' $hostname:2121 -u mn-wifi,mn-wifi
  # Check the exit code of the command
  if [ $? -ne 0 ]; then
    echo "lftp execution failed"
    exit 1  
  fi
  rm ~/tmp/512mb-file
  sleep 1
done