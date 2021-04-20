FROM alpine:3.12.3

RUN apk update
RUN echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add telegraf

COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf
ADD ./srcs ./srcs
WORKDIR /srcs
ENTRYPOINT ./config.sh