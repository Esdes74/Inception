#!/bin/sh

# Demarrage de mysql
service mariadb start;

# Creation d'une table
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# Creation d'un utilisateur qui puisse manipuler cette table
mysql -e "CREATE USER IF NOT EXITS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

# Don de tous les droits a cette utilisateur pour la table creee
mysql -e "GRANT ALL PRIVILIGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# Modification des droits du root
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# Refresh de mysql
mysql -e "FLUSH PRIVILEGES"

# Redemarrage de mysql
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

# Execution de mysql avec le mode safe
exec mysqld_safe
