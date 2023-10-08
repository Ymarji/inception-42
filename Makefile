# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ymarji <ymarji@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/08/11 11:14:16 by ymarji            #+#    #+#              #
#    Updated: 2023/08/23 14:36:52 by ymarji           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

RED = \033[1;31m
GREEN = \033[1;32m
NC = \033[1;0m

all:
	@echo "$(NC)--- $(GREEN)inception$(NC)\
	\n---\t $(RED)make clean$(NC)\t: to clean containers, images, volumes\
	\n---\t $(RED)make build$(NC)\t: to build the envirment"
	@echo "$(NC)--- $(GREEN)SRVICES$(NC)\
	\n---\t $(RED)wordpress$(NC)\t: https://localhost\
	\n---\t $(RED)WP Portal$(NC)\t: https://localhost/wp-admin\
	\n---\t $(RED)adminer$(NC)\t: http://localhost:9090\
	\n---\t $(RED)portfolio$(NC)\t: http://localhost:8080\
	\n---\t $(RED)pontainer$(NC)\t: https://localhost:9443"

build:
	docker-compose -f ./srcs/docker-compose.yaml up --build -d

stop:
	docker-compose -f ./srcs/docker-compose.yaml down

clean:
	docker-compose -f ./srcs/docker-compose.yaml down --rmi all -v --remove-orphans
	@docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q) 2>/dev/null
	@echo "$(GREEN)Remmoving Data directory ...$(NC)"
	@rm -rf ./data/*
	@echo "$(GREEN)Data directory removed$(NC)"
