FROM alpine

RUN apk update
RUN apk add nginx

ADD ./ ./srcs
WORKDIR /srcs
EXPOSE 80 443
ENTRYPOINT ./config.sh