FROM debian:oldstable

ARG DOMAIN_NAME

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    nginx \
    openssl && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -batch -x509 -sha256 -nodes -newkey rsa:2048 -days 365 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=BR/ST=SP/L=SP/O=42sp/CN=${DOMAIN_NAME}" && \
    chmod 755 /var/www/html && \
    chown -R www-data:www-data /var/www/html

COPY ./conf/nginx.conf /etc/nginx/conf.d

RUN sed -i 's/__domain__/${DOMAIN_NAME}/g' /etc/nginx/conf.d/nginx.conf

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]