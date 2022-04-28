# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: anadege <anadege@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/04/28 15:22:17 by anadege           #+#    #+#              #
#    Updated: 2022/04/28 15:57:26 by anadege          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

VOLUMES := /home/anadege/data

# Notes : in order to aandege.42.fr to be redirected to localhost, /etc/hosts file
# need to be modified
# https://stackoverflow.com/questions/15183929/how-to-redirect-any-specific-url-to-localhost-in-nginx
# Using wildcard function to check if /etc/hosts already modified
# https://stackoverflow.com/questions/5553352/how-do-i-check-if-file-exists-in-makefile-so-i-can-delete-it

all		:	conf up_d

conf	:
			sudo mkdir -p /home/anadege
			sudo mkdir -p $(VOLUMES)
			sudo mkdir -p $(VOLUMES)/wordpress
			sudo mkdir -p $(VOLUMES)/db
			if ! cat /etc/hosts | grep '127.0.0.1 anadege.42.fr'; then \
				sudo chmod 777 /etc/hosts; \
				sudo echo "127.0.0.1 anadege.42.fr" >> /etc/hosts; \
			fi
			
up		:	conf
			sudo docker-compose -f srcs/docker-compose.yml up --build

up_d	:	conf
			sudo docker-compose -f srcs/docker-compose.yml up --build -d

down	:	
			sudo docker-compose -f srcs/docker-compose.yml down

clean	:	down
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

fclean	:	clean
			sudo rm -rf $(VOLUMES)

re		:	clean	all

.PHONY	: all conf up up_d down clean fclean re
