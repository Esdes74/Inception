FROM debian:bullseye

# Configurer debconf pour utiliser l'interface non-interactive
ARG DEBIAN_FRONTEND=noninteractive

# Forcage des donnes pour la commande mariadb
ARG A_PASS
ARG A_DATABASE
ARG A_DATA_USER
ARG A_ROOT_PASS

ENV PASS=A_PASS
ENV DATABASE=A_DATABASE
ENV DATA_USER=A_DATA_USER
ENV ROOT_PASS=A_ROOT_PASS

# Update et Upgrade du system
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

# Installation de mariadb et vim
RUN apt-get install mariadb-server -y
# mariadb-client

RUN service mariadb start && mariadb -u root \
    -e "CREATE DATABASE IF NOT EXISTS ${DATABASE};" \
    -e "CREATE USER IF NOT EXISTS '${DATA_USER}' IDENTIFIED BY '${PASS}';" \
    -e "GRANT ALL PRIVILEGES ON ${DATABASE}.* TO '${DATA_USER}';" \
    -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${PASS}';" \
    -e "FLUSH PRIVILEGES;"

# Donne le port 3306
EXPOSE 3306

# Lancement du script de configuration de mariadb
ENTRYPOINT [ "mariadbd", "--bind-address=0.0.0.0"]
