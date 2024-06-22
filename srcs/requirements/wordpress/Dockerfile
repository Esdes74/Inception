FROM debian:bullseye

# Configurer debconf pour utiliser l'interface non-interactive
ARG DEBIAN_FRONTEND=noninteractive

# Update et Upgrade du system
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

# Installation de wget pour pouvoir telecharger wordpress
RUN apt-get install wget -y
RUN apt-get install vim -y

# Installation de php et de ses dépendances
RUN apt-get install php7.3 php-fpm php-mysql mariadb-client -y

# Copie de la configuration de php
COPY conf/php.ini /etc/php/7.4/cli

# Creation du repertoire dans lequel sera installe wordpress
RUN mkdir -p /var/www

# Installation de Wordpress
# -p me permet d'indiquer un repertoir ou installer Wordpress
RUN wget https://fr.wordpress.org/wordpress-6.5.4-fr_FR.tar.gz -P /var/www

# Decompression de l'archive telechargee
RUN tar -xzf /var/www/wordpress-6.5.4-fr_FR.tar.gz -C /var/www
RUN rm /var/www/wordpress-6.5.4-fr_FR.tar.gz

# Donne les droits a root
RUN chown -R root:root /var/www/wordpress

# Installation du cli pour pouvoir automatiser la configuration de wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Donne le droit et le met ou il faut
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Creer le repertoire d'installation du wordpress
RUN mkdir -p /var/www/html

# Copie du script de configuration de wordpress
RUN mkdir -p /var/run/wp
COPY ./tools/wp_config.sh /var/run/wp
RUN chmod +x /var/run/wp/wp_config.sh

# Installation de dumb-init pour gerer les processus
RUN apt-get install dumb-init -y

# Commence le conteneur avec le script de configuration
ENTRYPOINT ["/var/run/wp/wp_config.sh"]
