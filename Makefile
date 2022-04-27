VOLUMES := /home/anadege/data
DOCKER_CONTAINER_LIST := $(shell docker ps -a -q)

# Notes : in order to aandege.42.fr to be redirected to localhost, /etc/hosts file
# need to be modified
# https://stackoverflow.com/questions/15183929/how-to-redirect-any-specific-url-to-localhost-in-nginx
# Using wildcard function to check if /etc/hosts already modified
# https://stackoverflow.com/questions/5553352/how-do-i-check-if-file-exists-in-makefile-so-i-can-delete-it

all		:
			sudo mkdir -p /home/anadege
			sudo mkdir -p $(VOLUMES)
			sudo mkdir -p $(VOLUMES)/wordpress
			sudo mkdir -p $(VOLUMES)/db
			if ! cat /etc/hosts | grep '127.0.0.1 anadege.42.fr'; then \
				sudo chmod 777 /etc/hosts; \
				sudo echo "127.0.0.1 anadege.42.fr" >> /etc/hosts; \
			fi
			sudo docker-compose -f srcs/docker-compose.yml up --build

clean	:
			if [ -n "$(shell docker ps -a -q)" ] ; then \
				sudo docker stop $(shell docker ps -a -q); \
			fi
			sudo docker system prune --all --force --volumes
			sudo docker network prune --force
			sudo docker volume prune --force
			if [ -n "$(shell docker volume ls -q)" ] ; then \
				sudo docker volume rm $(shell docker volume ls -q); \
			fi
			sudo docker image prune --force
			sudo rm -rf $(VOLUMES)

re		: clean all

.PHONY: all clean fclean re
