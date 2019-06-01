FROM alpine
LABEL maintainer="yylbfyl@163.com"

ENV SERVER_ADDR 0.0.0.0
ENV SERVER_PORT 8388
ENV PASSWORD=
ENV METHOD      aes-256-cfb
ENV TIMEOUT     600
ENV DNS_ADDRS    8.8.8.8,8.8.4.4
ENV ARGS=

RUN set -ex \
 # Build environment setup
 && apk add --no-cache --virtual .build-deps \
      autoconf \
      automake \
      build-base \
      c-ares-dev \
      libev-dev \
      libtool \
      libsodium-dev \
      linux-headers \
      mbedtls-dev \
      pcre-dev \
      asciidoc \
      xmlto \
 # Build & install
RUN cd /tmp/ \
 && wget https://github.com/shadowsocks/shadowsocks-libev/releases/download/v3.2.5/shadowsocks-libev-3.2.5.tar.gz \
 && tar -xvzf shadowsocks-libev-3.2.5.tar.gz \
 && cd /tmp/shadowsocks-libev-3.2.5 \
 && ./configure \
 && make \
 && make install \
 && cp -a /tmp/shadowsocks-libev-3.2.5/src/ss-server /bin/ \
 && rm -rf /tmp/*

USER nobody

CMD exec ss-server \
      -s $SERVER_ADDR \
      -p $SERVER_PORT \
      -k ${PASSWORD:-$(hostname)} \
      -m $METHOD \
      -t $TIMEOUT \
      -d $DNS_ADDRS \
      -u \
      $ARGS

