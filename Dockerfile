#https://github.com/yeasy/docker-hyperledger-fabric-ca/blob/master/v1.2.0/Dockerfile
FROM hyperledger/fabric-ca:1.2.0
EXPOSE 7054
ENV FABRIC_CA_HOME=/etc/hyperledger/fabric-ca-server
ENV FABRIC_CA_SERVER_CA_NAME=fornax-ca
ENV FABRIC_CA_SERVER_CA_CERTFILE=/etc/hyperledger/fabric/crypto-config/ordererOrganizations/blockchain.com/ca/ca.blockchain.com-cert.pem
# FIXME testar se precisa mesmo do PEER0 ou poderá ficar assim mesmo:: /etc/hyperledger/fabric/crypto-config/peerOrganizations/org1.blockchain.com/ca/ca.org1.blockchain.com-cert.pem
ENV FABRIC_CA_SERVER_CA_KEYFILE=/etc/hyperledger/fabric/crypto-config/ordererOrganizations/blockchain.com/ca/

#pre-req etcd's.sh
RUN apt-get update && \
    apt-get install -y jq curl && \
    rm -rf /var/cache/apt

# fornax-orderer
LABEL maintainer="davimesquita@gmail.com"
ENV ETCD_ENDPOINT http://etcd:2379
COPY et.sh /bin/et
COPY etset.sh /bin/etset
COPY etdel.sh /bin/etdel
COPY etfile.sh /bin/etfile
COPY etoutput.sh /bin/etoutput
COPY fornax-ca.sh /bin/fornax-ca
WORKDIR $FABRIC_CA_ROOT
ENTRYPOINT ["/bin/bash"]
