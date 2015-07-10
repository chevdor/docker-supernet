#!/bin/bash

if [ "$NXTNET" = "main" ]; then
	ln -s /supernet/conf/nxt-main.properties /supernet/conf/nxt.properties
else
	ln -s /supernet/conf/nxt-test.properties /supernet/conf/nxt.properties
fi  

cd /supernet
./run.sh
