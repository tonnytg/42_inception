export LOGIN=antthoma

VOLUMES= /home/$(LOGIN)/data/mariadb \
		 /home/$(LOGIN)/data/wordpress \
		 /home/$(LOGIN)/data/adminer \
		 /home/$(LOGIN)/data/uptime-kuma

all: down up

up:
	@echo "Command: up"
	@if [ ! -d /home/$(LOGIN)/data ]; then \
		echo "Creating directory for data volume."; \
		sudo mkdir -p $(VOLUMES); \
	fi
	@sudo chmod 777 /home/$(LOGIN)
	@cd ./srcs && docker-compose up -d

up-build:
	@echo "Command: up-build"
	@cd ./srcs && docker-compose up --build -d	

stop:
	@echo "Command: stop"
	@cd ./srcs && docker-compose stop


down:
	@echo "Command: down"
	@cd ./srcs && docker-compose down

build:
	@echo "Command: build"
	@cd ./srcs && docker-compose up --build

logs:
	@echo "Command: logs"
	cd ./srcs && docker-compose logs

ps:
	@echo "Command: ps"
	cd ./srcs && docker-compose ps

connect:
	@echo "Command: connect"
	@docker exec -it $(TARGET) /bin/bash

rmi:
	@echo "Command: rmi"
	@docker rmi `docker image ls -q)`

rm-volumes:
	docker volume rm $$(docker volume ls -q)
	@rm -rf /home/$(LOGIN)/data

fclean:
	@echo "Command: fclean"
	cd ./srcs && docker-compose down && docker volume rm $$(docker volume ls -q)
	@sudo rm -rf /home/$(LOGIN)/data

re: fclean up-build