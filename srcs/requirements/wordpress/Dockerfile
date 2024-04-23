FROM debian:oldstable

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /var/www/html/wordpress

RUN apt-get update && apt-get install -y \
    telnet \
    php7.4 \
    php7.4-fpm \
    php7.4-cli \
    php7.4-curl \
    php7.4-mysql \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-gd \
    wget \
    mariadb-client \
    wordpress \
    vim

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    --output-document=/usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp && \
    mkdir -p /run/php /var/www/html/wordpress && \
    chmod -R 755 /var/www/html/wordpress && \
    wp core download --allow-root --path=/var/www/wordpress

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY ./tools/entrypoint.sh /usr/local/bin/

RUN chmod 755 /etc/php/7.4/fpm/pool.d/www.conf && \
    chmod +x /usr/local/bin/entrypoint.sh && \
    chown -R www-data:www-data /var/www

EXPOSE 9000

ENTRYPOINT ["entrypoint.sh"]

CMD ["/usr/sbin/php-fpm7.4","-F"]