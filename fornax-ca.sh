#!/bin/bash

cd $FABRIC_CFG_PATH
cd ..

et fornax-genesis | base64 -d | xargs -L 1 etoutput

orderer start


/etc/hyperledger/fabric-ca-server

#CMD ["bash", "-c", "fabric-ca-server start -b admin:adminpw"]
