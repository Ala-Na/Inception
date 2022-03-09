FROM debian:buster

# prevent package from prompting interactive input
ENV DEBIAN_FRONTEND=noninteractive

# install of nginx with -y option
RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get -y install nginx

# Container must listen on 443 port according to subjects
# It can be overide by docker run -p option
EXPOSE 443

# launch nginx in foreground and not background, advised for docker containers
# CMD could be use here but ENTRYPOINT is better for non additional set of argument
# as it can't be overlooked.
ENTRYPOINT ["nginx", "-g", "daemon off;"]
