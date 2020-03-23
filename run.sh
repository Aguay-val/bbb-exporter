#!/bin/bash

while true
do
  ./exporter-bis.sh https://<myserver> <mysecret>  | nc -l -p <listeningPort>
done
