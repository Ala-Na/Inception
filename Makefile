
# note : in order to aandege.42.fr to be redirected to localhost, /etc/hosts file
# need to be modified
# source : https://stackoverflow.com/questions/15183929/how-to-redirect-any-specific-url-to-localhost-in-nginx
# using wildcard function to check if /etc/hosts already modified
# source : https://stackoverflow.com/questions/5553352/how-do-i-check-if-file-exists-in-makefile-so-i-can-delete-it
all :
	@ if ! cat /etc/hosts | grep '127.0.0.1 anadege.42.fr'; then \
		echo "127.0.0.1 anadege.42.fr" >> /etc/hosts; \
	fi
	docker-compose -f srcs/docker-compose.yml up --build
 # TODO complete Makefile
