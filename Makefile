all: stop rm

stop:
	sudo docker stop $$(sudo docker ps -aq)										# Arrêter tous les conteneurs en cours d'exécution

rm: rmi
	sudo docker rm $$(sudo docker ps -aq)										# Supprimer tous les conteneurs
rmi: volume_rm
	sudo docker rmi $$(sudo docker images -q)									# Supprimer toutes les images

volume_rm: builder_rm
	sudo docker volume rm $$(sudo docker volume ls -q)								# Supprimer tous les volumes

builder_rm: system_rm
	sudo docker builder prune -a -f											# Nettoyer le cache de Docker (build cache)

system_rm: network_rm
	sudo docker system prune -a --volumes -f									# Nettoyer le cache général et les données non utilisées

network_rm:
	sudo docker network rm $$(sudo docker network ls | grep -vE 'NETWORK|DRIVER|ID|SERVER|SCOPE|bridge|host|none')	# Supprimer tous les réseaux
