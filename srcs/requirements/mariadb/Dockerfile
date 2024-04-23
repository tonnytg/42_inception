FROM debian:oldstable

COPY ./tools/docker-entrypoint.sh /usr/local/bin

RUN apt-get update -y && \
    apt-get install telnet lsof mariadb-server -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod +x /usr/local/bin/docker-entrypoint.sh

COPY ./conf/my.cnf /etc/mysql/my.cnf

# USER mysql

EXPOSE 3306

ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD ["mysqld_safe"]