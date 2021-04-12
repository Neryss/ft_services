FROM alpine:3.12.3

RUN apk update
RUN apk add mariadb
RUN apk add mariadb-client
RUN apk add openrc
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel
RUN rc-status 2> /dev/null

ADD ./srcs ./srcs
WORKDIR /srcs
EXPOSE 3306
ENTRYPOINT ./config.sh