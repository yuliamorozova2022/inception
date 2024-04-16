name = inception

SRC = ./srcs/docker-compose.yml

all:
	@printf "Launch configuration $(name)...\n"
  #@bash srcs/requirements/wordpress/tools/make_dir.sh
	@docker-compose -f $(SRC) --env-file srcs/.env up -d

build:
	@printf "Building configuration $(name)...\n"
  #@bash srcs/requirements/wordpress/tools/make_dir.sh
	@docker-compose -f $(SRC) --env-file srcs/.env up -d --build

down:
	@printf "Stopping configuration $(name)...\n"
	@docker-compose -f $(SRC) --env-file srcs/.env down

re: down
	@printf "Rebuild configuration $(name)...\n"
	@docker-compose -f $(SRC) --env-file srcs/.env up -d --build

clean: down
	@printf "Cleaning configuration $(name)...\n"
	@docker system prune -a
#	@sudo rm -rf ~/data/wordpress/*
#	@sudo rm -rf ~/data/mariadb/*

fclean:
	@printf "Total clean of all configurations docker\n"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@printf "Deleting volumes...\n"
	@docker volume prune --force
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

.PHONY	: all build down re clean fclean
