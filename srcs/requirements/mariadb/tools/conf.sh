#!/bin/sh

# Pour s'assurer que le script s'arrete a la premiere erreure
set -e

# Demarrage de mysql
service mariadb start;

# Creation d'une table
mysql -e "CREATE DATABASE IF NOT EXISTS \`${DATABASE}\`;"

# Creation d'un utilisateur qui puisse manipuler cette table
mysql -e "CREATE USER IF NOT EXITS \`${DATA_USER}\`@'localhost' IDENTIFIED BY '${PASS}';"

# Don de tous les droits a cette utilisateur pour la table creee
mysql -e "GRANT ALL PRIVILIGES ON \`${DATABASE}\`.* TO \`${DATA_USER}\`@'%' IDENTIFIED BY '${PASS}';"

# Modification des droits du root
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASS}';"

# Refresh de mysql
mysql -e "FLUSH PRIVILEGES"

# Redemarrage de mysql
mysqladmin -u root -p$ROOT_PASS shutdown

# Execution de mysql avec le mode safe
exec mysqld_safe
