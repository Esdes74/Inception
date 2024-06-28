V_MARIA := /home/eslamber/data/mariadb
V_WORD := /home/eslamber/data/wordpress

DOCKER := ./srcs/docker-compose.yml

all: rm_dir dir
	sudo docker-compose -f $(DOCKER) up -d --build
	
rm_dir:
	sudo rm -rf /home/eslamber/data

dir:
	sudo mkdir -p $(V_MARIA)
	sudo mkdir -p $(V_WORD)

fclean: rm rmi volume_rm builder_rm system_rm network_rm

stop:
	sudo docker stop $$(sudo docker ps -aq)										# Arrêter tous les conteneurs en cours d'exécution

down:
	sudo docker-compose -f $(DOCKER) down

rm:
	sudo docker rm $$(sudo docker ps -aq)										# Supprimer tous les conteneurs
rmi:
	sudo docker rmi $$(sudo docker images -q)									# Supprimer toutes les images

volume_rm:
	sudo docker volume rm $$(sudo docker volume ls -q)								# Supprimer tous les volumes

builder_rm:
	sudo docker builder prune -a -f											# Nettoyer le cache de Docker (build cache)

system_rm:
	sudo docker system prune -a --volumes -f									# Nettoyer le cache général et les données non utilisées

network_rm:
	sudo docker network rm $$(sudo docker network ls | grep -vE 'NETWORK|DRIVER|ID|SERVER|SCOPE|bridge|host|none')	# Supprimer tous les réseaux

.PHONY: all stop rm rmi volume_rm builder_rm system_rm network_rm fclean dir rm_dir down
