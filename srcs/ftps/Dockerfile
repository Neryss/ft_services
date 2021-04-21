FROM alpine:3.12.3

RUN apk update
RUN echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

ADD ./srcs /srcs
WORKDIR srcs
EXPOSE 21
ENTRYPOINT ./config.sh