# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: c3b5aw <dev@c3b5aw.dev>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/10/18 14:24:39 by c3b5aw            #+#    #+#              #
#    Updated: 2021/10/26 15:17:25 by c3b5aw           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SRCS 			:= ./srcs
DOCKER			:= sudo docker
COMPOSE 		:= cd srcs/ && sudo docker-compose
DATA_PATH 		:= /home/c3b5aw/data

#	-	[	all	]
#
#	Down every containers
#	Build images
#	Run containers in background.
.PHONY	:	all
all		:	build
		sudo mkdir -p $(DATA_PATH)
		sudo mkdir -p $(DATA_PATH)/monitoring
		sudo mkdir -p $(DATA_PATH)/wordpress
		sudo mkdir -p $(DATA_PATH)/database
		sudo mkdir -p $(DATA_PATH)/cv
ifeq ("$(wildcard .setup)","")
	@ printf "[\033[0;32m+\033[m] Applying DNS redirection\n"
	sudo chmod 777 /etc/hosts
	sudo echo "127.0.0.1 c3b5aw.42.fr" >> /etc/hosts
	touch .setup
endif
		$(COMPOSE) up -d

#	-	[	build	]
#
#	Build images that differs.
.PHONY	:	build
build	:
		$(COMPOSE) build

#	-	[	down	]
#
#	Down each image in compose.
.PHONY	:	down
down	:
		$(COMPOSE) down

#	-	[	clean	]
#
#	Down each image in compose and destroy associated volumes.
.PHONY	:	clean
clean	:
		$(COMPOSE) down -v --rmi all --remove-orphans

#	-	[	fclean	]
#
#	Down each images and destroy associated volumes.
#	Destroy data directory.
.PHONY	:	fclean
fclean	:	clean
		$(DOCKER) system prune --volumes --all --force
		sudo rm -rf $(DATA_PATH)
		$(DOCKER) network prune --force
		$(DOCKER) volume prune --force
		$(DOCKER) image prune --force

#	-	[	re	]
#
#	Cleanup environnement and rebuild everything.
.PHONY	:	re
re		:	fclean all
