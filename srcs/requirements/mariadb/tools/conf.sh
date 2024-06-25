#!/bin/sh

# Pour s'assurer que le script s'arrête à la première erreur
set -e

# Chemin du fichier de log
touch /mariadb.log
LOGFILE=/mariadb.log

#ARG DATABASE
#ARG DATA_USER
#ARG PASS
#ARG ROOT_PASS

# Fonction pour loguer les messages
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOGFILE
}

# Demarrage de MariaDB
log "Starting MariaDB..."
service mariadb start

# Attendre que le service MariaDB soit complètement démarré
log "Waiting for MariaDB to start..."
while ! mysqladmin ping --silent; do
    log "Waiting for MariaDB to be available..."
    sleep 2
done

# Creation d'une base de données
log "Creating database ${DATABASE}..."
mysql -uroot -p"${ROOT_PASS}" -e "CREATE DATABASE IF NOT EXISTS ${DATABASE};" 2>&1 | tee -a $LOGFILE

# Creation d'un utilisateur qui puisse manipuler cette base de données
log "Creating user ${DATA_USER}..."
mysql -uroot -p"${ROOT_PASS}" -e "CREATE USER IF NOT EXISTS '${DATA_USER}'@'localhost' IDENTIFIED BY '${PASS}';"

# Don de tous les droits à cet utilisateur pour la base de données créée
log "Granting privileges to ${DATA_USER}..."
mysql -u root -p"${ROOT_PASS}" -e "GRANT ALL PRIVILEGES ON ${DATABASE}.* TO '${DATA_USER}'@'localhost' IDENTIFIED BY '${PASS}';" 2>&1 | tee -a $LOGFILE

# Modification des droits du root
log "Changing password for root..."
mysql -u root -p"${ROOT_PASS}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASS}';" 2>&1 | tee -a $LOGFILE

# Refresh de MariaDB
log "Flushing privileges..."
mysql -u root -p"${ROOT_PASS}" -e "FLUSH PRIVILEGES" 2>&1 | tee -a $LOGFILE

# Redemarrage de MariaDB
log "Shutting down MariaDB..."
mysqladmin -u root -p"${ROOT_PASS}" shutdown 2>&1 | tee -a $LOGFILE

# Execution de MariaDB avec le mode safe
log "Starting MariaDB in safe mode..."
exec mysqld_safe

#!/bin/sh

# Pour s'assurer que le script s'arrete a la premiere erreure
#set -e

# Demarrage de mysql
#service mariadb start;

# Creation d'une table
#mysql -uroot -p"${ROOT_PASS}" -e "CREATE DATABASE IF NOT EXISTS \`${DATABASE}\`;"

# Creation d'un utilisateur qui puisse manipuler cette table
#mysql -uroot -p"${ROOT_PASS}" -e "CREATE USER IF NOT EXISTS \`${DATA_USER}\`@'localhost' IDENTIFIED BY '${PASS}';"

# Don de tous les droits a cette utilisateur pour la table creee
#mysql -uroot -p"${ROOT_PASS}" -e "GRANT ALL PRIVILEGES ON \`${DATABASE}\`.* TO \`${DATA_USER}\`@'%' IDENTIFIED BY '${PASS}';"

# Modification des droits du root
#mysql -uroot -p"${ROOT_PASS}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASS}';"

# Refresh de mysql
#mysql -uroot -p"${ROOT_PASS}" -e "FLUSH PRIVILEGES"

# Redemarrage de mysql
#mysqladmin -uroot -p"${ROOT_PASS}" shutdown

# Execution de mysql avec le mode safe
#exec mysqld_safe
