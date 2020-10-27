#!/bin/bash

CURRENT=$(($(curl --silent https://api.helium.io/v1/blocks/height -q | jq '.data.height')+0 ))
MINER=$(($(docker exec $1 miner info height | cut -f 3)+0 ))
BEHIND=$(( $CURRENT - $MINER ))
PBEHIND=$(bc <<< "scale=2; $MINER/$CURRENT*100")
echo "Behind by: $BEHIND blocks"
echo "Miner: $MINER ($PBEHIND%)"
echo "Current Height: $CURRENT"