#!/bin/bash

# Check if at least one argument is passed
if [ $# -eq 1 ]; then
    hostname=$1
else
    echo "Syntax: ./httpclient.sh hostname"
    exit 1
fi

while true; do
  curl -o /dev/null -s -w '%{time_total}\n' $hostname:8080
  # Check the exit code of the command
  if [ $? -ne 0 ]; then
    echo "curl execution failed"
    exit 1  
  fi
  sleep 1
done
