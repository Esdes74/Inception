FROM debian:bullseye

# Configurer debconf pour utiliser l'interface non-interactive
ARG DEBIAN_FRONTEND=noninteractive

# Update et Upgrade du system
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

# Installation de nginx
RUN apt-get install nginx -y

# Creation du repertoire ssl pour y stocker la clee et le certificat
RUN mkdir -p /etc/nginx/ssl

# Installation de openssl
RUN apt-get install openssl -y

# Creation de la clee et du certificat
RUN openssl req -x509 -newkey rsa:2048 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=AURA/L=Lyon/O=42/OU=42/CN=eslamber.42.fr/UID=eslamber"

# Ajout de la configuration de nginx
COPY conf/nginx.conf /etc/nginx/sites-available/eslamber.42.fr.conf

RUN echo "include /etc/nginx/sites-available/eslamber.42.fr.conf;" > /etc/nginx/sites-enabled/eslamber.42.fr.conf

# Execute nginx avec les variables globales (-g) et en arriere plan (daemon off)
CMD ["nginx", "-g", "daemon off;"]
