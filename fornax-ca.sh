#!/bin/bash

function main() {

precert

cpdir ./crypto-config/peerOrganizations/org1.blockchain.com/ca/ /etc/hyperledger/fabric-ca-server-config

cd $FABRIC_CA_SERVER_CA_KEYFILE
export FABRIC_CA_SERVER_CA_KEYFILE=$FABRIC_CA_SERVER_CA_KEYFILE$(ls *_sk)
cd $FABRIC_CA_HOME
fabric-ca-server start -b $FABRIC_CA_USER:$FABRIC_CA_PW

};

function cpdir() {
    cd /etc/fornax/fabric
    mkdir -p $2
    cp -r $1/* $2
};
function precert() {
mkdir -p /etc/fornax
cd /etc/fornax
et fornax-genesis | base64 -d | xargs -L 1 etoutput
};

main
