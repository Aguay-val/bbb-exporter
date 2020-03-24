#!/bin/bash

while true
do
  ./exporter.sh https://BBB_ENDPOINT BBB_SECRET  | nc -l -p LISTENING_PORT
done
