FROM postgres:12
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install cmake make gcc pkg-config libglib2.0-dev libgpgme-dev libgnutls28-dev uuid-dev libssh-gcrypt-dev libhiredis-dev libxml2-dev libpcap-dev gcc cmake libglib2.0-dev libgnutls28-dev libpq5=12.5-1.pgdg100+1 libpq-dev=12.5-1.pgdg100+1 postgresql-server-dev-12 pkg-config libical-dev xsltproc wget ca-certificates --no-install-recommends -y --allow-downgrades

RUN cd /opt/ && wget https://github.com/greenbone/gvm-libs/archive/v20.8.0.tar.gz -O gvm-libs-v20.8.0.tar.gz && wget https://github.com/greenbone/gvmd/archive/v20.8.0.tar.gz -O gvmd-v20.8.0.tar.gz && tar -xvzf gvm-libs-v20.8.0.tar.gz && cd gvm-libs-20.8.0 && cmake -DCMAKE_INSTALL_PREFIX=/usr . && make && make install && cd .. && tar -xvzf gvmd-v20.8.0.tar.gz && cd gvmd-20.8.0 && cmake -DPostgreSQL_TYPE_INCLUDE_DIR=/usr/include/postgresql . && make && make install && cd .. && rm -rf *

