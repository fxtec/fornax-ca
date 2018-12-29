#https://github.com/yeasy/docker-hyperledger-fabric-ca/blob/master/v1.2.0/Dockerfile
FROM hyperledger/fabric-ca:1.2.0
EXPOSE 7054
ENV FABRIC_CA_HOME=/etc/hyperledger/fabric-ca-server
ENV FABRIC_CA_SERVER_CA_NAME=ca.blockchain.com
ENV FABRIC_CA_SERVER_CA_CERTFILE=/etc/hyperledger/fabric-ca-server-config/ca.org1.blockchain.com-cert.pem
ENV FABRIC_CA_SERVER_CA_KEYFILE=/etc/hyperledger/fabric-ca-server-config/

#pre-req etcd's.sh
RUN apt-get update && \
    apt-get install -y jq curl && \
    rm -rf /var/cache/apt

# fornax-ca
LABEL maintainer="davimesquita@gmail.com"
ENV ETCD_ENDPOINT http://etcd:2379
ENV FABRIC_CA_USER admin
ENV FABRIC_CA_PW adminpw
COPY et.sh /bin/et
COPY etset.sh /bin/etset
COPY etdel.sh /bin/etdel
COPY etfile.sh /bin/etfile
COPY etoutput.sh /bin/etoutput
RUN chmod +x /bin/et
RUN chmod +x /bin/etset
RUN chmod +x /bin/etdel
RUN chmod +x /bin/etfile
RUN chmod +x /bin/etoutput
COPY fornax-ca.sh /bin/fornax-ca
RUN chmod +x /bin/fornax-ca
ENTRYPOINT ["/bin/fornax-ca"]
