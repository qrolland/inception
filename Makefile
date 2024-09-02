name = inception

all: up

up: setup
	docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
	docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

start:
	docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env start

stop:
	docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env stop

status:
	cd srcs && docker-compose ps && cd ..

logs:
	cd srcs && docker-compose logs && cd ..

setup:
	sudo mkdir -p ~/data
	sudo mkdir -p ~/data/mariadb-data
	sudo mkdir -p ~/data/wordpress-data

clean: down
	sudo rm -rf ~/data

fclean: clean stop
	docker system prune -f -a --volumes
	docker volume rm srcs_mariadb-data srcs_wordpress-data
	docker network prune -f
.PHONY: all up down start stop status logs prune clean fclean
