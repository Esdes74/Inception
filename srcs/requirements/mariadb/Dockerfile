FROM debian:bullseye

ARG DATABASE
ARG DATA_USER
ARG PASS
ARG ROOT_PASSWORD

# Update, Upgrade et installe ce dont il y a besoin
RUN apt-get update -y && apt-get upgrade -y && apt-get install mariadb-server -y

# Lance mariadb et donne les droits a root
RUN service mariadb start && mariadb -e "GRANT ALL PRIVILEGES ON * . * TO 'root'@'localhost';" \
&& mariadb -e "FLUSH PRIVILEGES;"

# Lance mariadb et creer la base de donnee
RUN service mariadb start && mariadb -e "CREATE DATABASE IF NOT EXISTS ${DATABASE};" \
&& mariadb -e "CREATE USER IF NOT EXISTS '${DATA_USER}'@'localhost' IDENTIFIED BY '${PASS}';" \
&& mariadb -e "GRANT ALL PRIVILEGES ON ${DATABASE}.* to '${DATA_USER}'@'%' IDENTIFIED BY '${PASS}';" \
&& mariadb -e "FLUSH PRIVILEGES;"

# demarre mariadb en mettant ok sur toutes les adresses
CMD ["mariadbd", "--bind-address=0.0.0.0"]
