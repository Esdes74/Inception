FROM debian:bullseye

ARG DATABASE
ARG DATA_USER
ARG PASS
ARG ROOT_PASSWORD

# Check for packages updates & install mariadb
RUN apt-get update -y && apt-get upgrade -y && apt-get install mariadb-server -y

# Launch and create database
# FLUSH is a refresh to update with the changes done before
RUN service mariadb start && mariadb -e "GRANT ALL PRIVILEGES ON * . * TO 'root'@'localhost';" \
&& mariadb -e "FLUSH PRIVILEGES;"

RUN service mariadb start && mariadb -e "CREATE DATABASE IF NOT EXISTS ${DATABASE};" \
&& mariadb -e "CREATE USER IF NOT EXISTS '${DATA_USER}'@'localhost' IDENTIFIED BY '${PASS}';" \
&& mariadb -e "GRANT ALL PRIVILEGES ON ${DATABASE}.* to '${DATA_USER}'@'%' IDENTIFIED BY '${PASS}';" \
&& mariadb -e "FLUSH PRIVILEGES;"

# bind 0.0.0.0 allows to listen on every networks
CMD ["mariadbd", "--bind-address=0.0.0.0"]
