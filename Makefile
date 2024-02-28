# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ymarji <ymarji@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/08/11 11:14:16 by ymarji            #+#    #+#              #
#    Updated: 2024/02/23 14:36:43 by ymarji           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

include ./srcs/.env

RED = \033[1;31m
GREEN = \033[1;32m
NC = \033[1;0m

all:
	@echo "$(NC)--- $(GREEN)inception$(NC)\
	\n---\t $(RED)make clean$(NC)\t: to clean containers, images, volumes\
	\n---\t $(RED)make build$(NC)\t: to build the envirment"
	@echo "$(NC)--- $(GREEN)SRVICES$(NC)\
	\n---\t $(RED)wordpress$(NC)\t: https://${HOST}/\
	\n---\t $(RED)WP Portal$(NC)\t: https://${HOST}/wp-admin\
	\n---\t $(RED)adminer$(NC)\t: http://${HOST}:9090\
	\n---\t $(RED)portfolio$(NC)\t: http://${HOST}:8080\
	\n---\t $(RED)pontainer$(NC)\t: https://${HOST}:9443"

build:
	mkdir -p ~/data/mysql
	mkdir -p ~/data/wp
	mkdir -p ~/data/adminer
	mkdir -p ~/data/portainer
	docker-compose -f ./srcs/docker-compose.yaml build --no-cache
	# docker-compose -f ./srcs/docker-compose.yaml build
	docker-compose -f ./srcs/docker-compose.yaml up -d --force-recreate

stop:
	docker-compose -f ./srcs/docker-compose.yaml down

clean:
	@docker-compose -f ./srcs/docker-compose.yaml down --rmi all -v --remove-orphans

fclean:
	@echo "$(GREEN)Remmoving Data directory ...$(NC)"
	@sudo rm -rf ~/data/*
	@docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q) 2>/dev/null
	@echo "$(GREEN)Data directory removed$(NC)"
