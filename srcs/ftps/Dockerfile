FROM alpine:3.12.3

RUN apk update
RUN echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add openrc
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel
RUN rc-status 2> /dev/null

RUN apk add vsftpd

RUN adduser -D "admin"
RUN echo "admin:admin" | chpasswd 2>/dev/null

ADD ./srcs /srcs

WORKDIR /

ADD ./srcs/vsftpd.conf /etc/vsftpd

ADD ./ip.txt /ip.txt

RUN echo "pasv_address=$(cat /ip.txt)" >> /etc/vsftpd/vsftpd.conf

EXPOSE 21 30020 30021
ENTRYPOINT ./srcs/config.sh