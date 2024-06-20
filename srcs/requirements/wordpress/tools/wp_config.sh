#!/bin/sh

# Pour s'assurer que le script s'arrete a la premiere erreure
set -e

# Afin d'etre sur que tous soit bien installé
until mysqladmin ping -hmariadb --silent; do
	echo Waiting for mariadb...
	sleep 2
done

if ! wp core is-installed --path=${INSTAL_WP}; then
	# Telechargement des fichiers de wordpress
	wp core download --path=${INSTAL_WP} --allow-root
	# Creation de la config
	wp config creat \
		--dbname ${DB_NAME}\
		--dbuser ${DB_USER}\
		--dbhost ${DB_HOST}\
		--dbpass ${DB_PASS}\
		--path=${INSTAL_WP} --allow-root
	# Creation du site et de l'admin
	wp core install \
		--url= ${URL}\
		--title= ${TITLE}\
		--admin_user= ${ADMIN}\
		--admin_password= ${ADMIN_PASS}\
		--admin_email= ${ADMIN_MAIL}\
		--path=${INSTAL_WP} --allow-root
	# Creation du User
	wp user creat ${USER} ${USER_MAIL} --role=${USER_ROLE} --user_pass=${USER_PASS} --path=${INSTAL_WP} --allow-root
fi

# Lancement de php-fpm
php-fpm7.3 -F
