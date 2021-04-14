FROM alpine:3.12.3

RUN apk update
RUN echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add grafana
RUN apk add openrc
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel
RUN rc-status 2> /dev/null

ADD ./srcs /srcs
WORKDIR /srcs
EXPOSE 3000
ENTRYPOINT ./config.sh