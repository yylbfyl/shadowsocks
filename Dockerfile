FROM alpine
LABEL maintainer="yylbfyl@163.com"

ENV SERVER_ADDR 0.0.0.0
ENV SERVER_PORT 8388
ENV PASSWORD=
ENV METHOD      aes-256-cfb
ENV TIMEOUT     600
ENV LOCAL_PORT    1080 
ENV DNS_ADDRS    8.8.8.8,8.8.4.4
ENV ARGS=

COPY ./ss-server /bin/

USER nobody

CMD exec ss-server \
      -s $SERVER_ADDR \
      -p $SERVER_PORT \
      -k ${PASSWORD:-$(hostname)} \
      -m $METHOD \
      -t $TIMEOUT \
      -l $LOCAL_PORT \
      -d $DNS_ADDRS \
      -u \
      $ARGS

