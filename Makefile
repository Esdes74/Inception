all: 
	sudo docker-compose -f ./srcs/docker-compose.yml up -d --build
	
dir:
	sudo mkdir -p /home/eslamber/data/mariadb
	sudo mkdir -p /home/eslamber/data/wordpress

fclean: stop rm rmi volume_rm builder_rm system_rm network_rm

stop:
	sudo docker stop $$(sudo docker ps -aq)										# Arrêter tous les conteneurs en cours d'exécution

down:
	sudo docker-compose -f ./srcs/docker-compose.yml down

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

.PHONY: all stop rm rmi volume_rm builder_rm system_rm network_rm fclean dir
