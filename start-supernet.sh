#!/bin/bash
cd /supernet

if [ "$NXTNET" = "main" ]; then
	DB="nxt_db"
else
	DB="nxt_test_db"
fi  

echo Database is $DB

# if we need to bootstrap, we do that first.
# Warning, bootstrapping will delete the current blockchain.
# This ENV variable must be removed for the container
# to start 'normally'.
# $BLOCKCHAINDL must point to a zip that contains the nxt_db folder itself.
if [ -n "${BLOCKCHAINDL-}" ] && [ ! -d "$DB" ]; then
	echo "$DB not found, downloading blockchain from $BLOCKCHAINDL";
	wget "$BLOCKCHAINDL" && unzip *.zip && rm *.zip
	echo "Blockchain download complete"
fi

if [ "$NXTNET" = "main" ]; then
	echo "Linking config to mainnet"
	ln -sf /supernet/conf/nxt-main.properties /supernet/conf/nxt.properties
else
	echo "Linking config to testnet"
	ln -sf /supernet/conf/nxt-test.properties /supernet/conf/nxt.properties
fi  

./run.sh

