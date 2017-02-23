FROM alpine:3.5

RUN apk update \
  && apk add bash docker

ADD run.sh /

ENTRYPOINT ["./run.sh"]