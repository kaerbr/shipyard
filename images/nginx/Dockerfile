FROM nginx:alpine

LABEL org.opencontainers.image.description="Mein eigener Nginx Webserver"
LABEL maintainer="Dein Name"

RUN rm -rf /usr/share/nginx/html/*

COPY src/ /usr/share/nginx/html/

EXPOSE 80
