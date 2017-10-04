# Dockerfile for openresty
# VERSION   0.1.4

FROM ubuntu:16.04
MAINTAINER Ankit Mittal <ankitml@gmail.com>
ENV REFRESHED_AT 2017-03-20

ENV    DEBIAN_FRONTEND noninteractive && \
  echo "deb-src http://archive.ubuntu.com/ubuntu xenial main" >> /etc/apt/sources.list && \
  sed 's/main$/main universe/' -i /etc/apt/sources.list && \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get -y install wget vim git libpq-dev && \
  apt-get -y install lua5.2 && \
  apt-get -y install liblua5.2-dev && \
  apt-get -y install unzip


# Openresty (Nginx)
RUN    apt-get -y build-dep nginx \
  && apt-get -q -y clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
RUN    wget http://openresty.org/download/openresty-1.11.2.2.tar.gz  \
  && tar xvfz openresty-1.11.2.2.tar.gz  \
  && cd openresty-1.11.2.2 \
  && ./configure --with-luajit  --with-http_addition_module --with-http_dav_module --with-http_geoip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_realip_module --with-http_stub_status_module --with-http_ssl_module --with-http_sub_module --with-http_xslt_module --with-ipv6 --with-http_postgres_module --with-pcre-jit \
  && make \
  && make install \
  && rm -rf /ngx_openresty*


RUN \
  wget http://luarocks.org/releases/luarocks-2.2.0.tar.gz && \
  tar -xzvf luarocks-2.2.0.tar.gz && \
  rm -f luarocks-2.2.0.tar.gz && \
  cd luarocks-2.2.0 && \
  ./configure && \
  make build && \
  make install && \
  make clean && \
  cd .. && \
  rm -rf luarocks-2.2.0


