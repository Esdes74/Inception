FROM debian:bullseye

# Configurer debconf pour utiliser l'interface non-interactive
ARG DEBIAN_FRONTEND=noninteractive

# Forcage des donnes pour la commande mariadb
ARG PASS
ARG DATABASE
ARG DATA_USER
ARG ROOT_PASS

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
