
#from this image container will be created
FROM alpine:3.16

ARG DB_NAME \
    DB_USER \
    DB_PASS
#what sofware and how will be installed inside the mariadb container
# 	you can't run application from RUN instruction straightforward.
#	CMD and ENTRYPOINT instructions are used for it
#	RUN creates a static layer, changes in that layer are writed to image
#	and CMD/ENTRYPOIN run smthg, but don't write changes to the image

#	apk - file manager(like apt). updates repos, updates old packages, installs
#	mariadb without saving sources in cache
RUN apk update && apk add --no-cache mariadb mariadb-client
# one command gives one layer
# tee sends echo result to the file
# sed command replaces lines inside the file
RUN mkdir /var/run/mysqld; \
    chmod 777 /var/run/mysqld; \
    { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      echo 'skip-name-resolve'; \
      echo 'bind-address=0.0.0.0'; \
    } | tee  /etc/my.cnf.d/docker.cnf; \
    sed -i "s|skip-networking|skip-networking=0|g" \
      /etc/my.cnf.d/mariadb-server.cnf
# next layer - actually creating of database
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql
# port for container communication and traffic
EXPOSE 3306

COPY requirements/mariadb/conf/create_db.sh .
RUN sh create_db.sh && rm create_db.sh
# change user 
USER mysql
# start of database
CMD ["/usr/bin/mysqld", "--skip-log-error"]
