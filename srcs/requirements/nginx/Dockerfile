FROM debian:bullseye

# Update et Upgrade du system
RUN apt-get update -y
RUN apt-get upgrade -y

# Installation de nginx et vim
RUN apt-get install nginx -y
RUN apt-get install vim -y

# Creation du repertoire ssl pour y stocker la clee et le certificat
RUN mkdir -p /etc/nginx/ssl

# Installation de openssl
RUN apt-get install openssl -y

# Creation de la clee et du certificat
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=eslamber.42.fr/UID=eslamber"

# Creation du repertoire pour stocker la configuration de nginx
RUN mkdir -p /var/run/nginx

# Ajout de la configuration de nginx
COPY conf/nginx /etc/nginx/nginx.conf

# Modification des autorisation pour s'assurer qu'on les as
RUN chmod 755 /var/www/html

# Donne le port 443 a écouter
EXPOSE 443

# Installation de dumb-init pour gerer les processus
RUN apt-get install dumb-init -y

# Execute nginx avec les variables globales (-g) et en arriere plan (daemon off)
CMD ["nginx", "-g", "daemon off;"]
