FROM alpine:3.12.3

RUN apk update
RUN apk add nginx
RUN apk add openrc
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel
RUN rc-status 2> /dev/null

ADD ./srcs ./srcs
WORKDIR /srcs
EXPOSE 80 443
ENTRYPOINT ./config.sh