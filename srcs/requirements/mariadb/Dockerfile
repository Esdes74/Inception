FROM debian:bullseye

# Update et Upgrade du system
RUN apt-get update -y
RUN apt-get upgrade -y

# Installation de mariadb et vim
RUN apt-get install mariadb-server mariadb-client -y
RUN apt-get install vim -y

RUN mkdir -p /var/run/mysql
RUN mkdir -p /var/lib/mysql

# Ajout de la configuration de mariadb
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/conf.sh /var/run/mysql
RUN chmod +x /var/run/mysql/conf.sh

EXPOSE 3306


