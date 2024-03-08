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

include ./requirements/.env

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
	# docker-compose -f ./requirements/docker-compose.yaml build --no-cache
	docker-compose -f ./requirements/docker-compose.yaml build 
	docker-compose -f ./requirements/docker-compose.yaml up -d --force-recreate

down:
	docker-compose -f ./requirements/docker-compose.yaml down

clean:
	@docker-compose -f ./requirements/docker-compose.yaml down --rmi all -v --remove-orphans

fclean: clean
	@echo "$(GREEN)Remmoving Data directory ...$(NC)"
	@sudo rm -rf ~/data/*
	@echo "$(GREEN)Data directory removed$(NC)"
