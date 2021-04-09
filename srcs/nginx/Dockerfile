FROM alpine:3.12.3

RUN apk update
RUN apk add nginx

ADD ./srcs ./srcs
WORKDIR /srcs
EXPOSE 80 443
ENTRYPOINT ./srcs/config.sh