FROM postgres:12
ARG DEBIAN_FRONTEND=noninteractive
ENV VERSION=20.8.0

RUN apt-get update && apt-get install cmake make gcc pkg-config libglib2.0-dev libgpgme-dev libgnutls28-dev uuid-dev libssh-gcrypt-dev libhiredis-dev libxml2-dev libpcap-dev gcc cmake libglib2.0-dev libgnutls28-dev libpq5=12.5-1.pgdg100+1 libpq-dev=12.5-1.pgdg100+1 postgresql-server-dev-12 pkg-config libical-dev xsltproc wget ca-certificates --no-install-recommends -y --allow-downgrades

WORKDIR /opt
RUN wget https://github.com/greenbone/gvm-libs/archive/v${VERSION}.tar.gz -O gvm-libs-v${VERSION}.tar.gz && tar -xvzf gvm-libs-v${VERSION}.tar.gz && cd gvm-libs-${VERSION} && cmake -DCMAKE_INSTALL_PREFIX=/usr . && make && make install && cd .. && rm -rf *
RUN wget https://github.com/greenbone/gvmd/archive/v${VERSION}.tar.gz -O gvmd-v${VERSION}.tar.gz && tar -xvzf gvmd-v${VERSION}.tar.gz && cd gvmd-${VERSION} && cmake -DPostgreSQL_TYPE_INCLUDE_DIR=/usr/include/postgresql . && make && make install && cd .. && rm -rf *
