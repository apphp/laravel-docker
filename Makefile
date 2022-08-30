## -------------------------------------------------
## GLOBAL VARIABLES
## -------------------------------------------------

# Options: full|mini
profile := full
# Colors
GRAY := \033[1;30m
GREEN := \033[0;32m
YELLOW := \033[1;33m
RED := \033[33;31m
DARKCYAN := \033[33;36m
NC := \033[0m

## -------------------------------------------------

## COMMON
## -------------------------------------------------
hello: app-hello info
help: app-help
all-commands: app-hello info-docker

check-you-sure:
	@echo -n "Are you sure? [y/N] " && read ans && [ $${ans:-N} = y ]

app-hello:
	@echo ""
	@echo "${YELLOW}---------------------------------------------------${NC}"
	@echo "${YELLOW}Hello there! What would you like to do?${NC}"
	@echo "${YELLOW}---------------------------------------------------${NC}"

info:
	@echo "${GREEN}info-docker${NC} \t\t - list of commands for docker"
	@echo "${GREEN}info-composer${NC} \t\t - list of commands for Composer"

app-help: info-docker

info-docker:
	@echo ""
	@echo "${GRAY}# -------------------------------------------------"
	@echo "# DOCKER"
	@echo "# -------------------------------------------------${NC}"
	@echo "${GREEN} init${NC} \t\t\t - perform full initialization of docker"
	@echo "${GREEN} up${NC} \t\t\t - run docker containers"
	@echo "${GREEN} down${NC} \t\t\t - down docker containers"
	@echo "${GREEN} rebuild${NC} \t\t - rebuild docker containers"
	@echo "${GREEN} rebuild-container${NC} \t - rebuild specific container: 'make rebuild-container container=<name>'"
	@echo "${GREEN} reset${NC} \t\t\t - down all docker containers and run them again"
	@echo "${GREEN} reset-container${NC} \t - reset specific container: 'make reset-container container=<name>'"
	@echo "${GREEN} recreate-container${NC} \t - recreate specific container: 'make recreate-container container=<name>'"
	@echo "${GREEN} ps${NC} \t\t\t - show running docker containers"
	@echo "${GREEN} remove-images${NC} \t\t - remove all docker images"
	@echo "${GREEN} remove-all${NC} \t\t - remove all docker images and containers"

info-composer:
	@echo ""
	@echo "${GRAY}# -------------------------------------------------"
	@echo "# COMPOSER"
	@echo "# -------------------------------------------------${NC}"
	@echo "${GREEN} composer-v${NC} \t\t - show current version of composer"
#	@echo "${GREEN} composer-install${NC} \t - install the defined dependencies"
#	@echo "${GREEN} composer-no-dev${NC} \t - install the defined dependencies without dev packages"
#	@echo "${GREEN} composer-update${NC} \t - initially install the defined dependencies"
#	@echo "${GREEN} composer-dump${NC} \t\t - re-generate the vendor/autoload.php file"
#	@echo "${GREEN} composer-du${NC} \t\t - alias for composer-dump command"
#	@echo "${GREEN} composer-require${NC} \t - install specific package: 'make composer-require package=<name>'"
#	@echo "${GREEN} composer-require-dev${NC} \t - install specific package: 'make composer-require-dev package=<name>'"
#	@echo "${GREEN} composer-clear${NC} \t - remove vendor/ directory and composer.lock file"


## -------------------------------------------------
## DOCKER
## -------------------------------------------------
init: docker-down docker-pull docker-build-pull docker-up app-init docker-ps
rebuild: check-you-sure docker-down docker-rebuild docker-ps
reset: docker-down docker-up docker-ps
reset-container: docker-reset-container
recreate-container: docker-recreate-container
rebuild-container: docker-rebuild-container
ps: docker-ps
up: docker-up docker-ps
down: docker-down
remove-images: docker-prune-images
remove-all: docker-prune-all

docker-ps:
	docker-compose ps

docker-up: set-docker-up

set-docker-up:
	docker-compose --profile $(profile) up -d

docker-rebuild-container:
	docker-compose  --profile $(profile) up --build -d $(container)
	docker-compose ps

docker-reset-container:
	docker-compose rm -s -v $(container)
	docker-compose up -d $(container)
	docker-compose ps

docker-recreate-container:
	docker-compose --profile $(profile) up --force-recreate -d $(container)
	docker-compose ps

docker-rebuild:
	docker-compose --profile $(profile) up --build -d

docker-down:
	docker-compose down -v --remove-orphans

docker-pull:
	docker-compose pull

docker-build-pull:
	docker-compose build --pull

docker-prune-images:
	docker image prune -a -f

docker-prune-all:
	docker-compose down
	docker rm -f $(docker ps -a -q)
	docker volume rm $(docker volume ls -q)
	docker image prune -a -f



## -------------------------------------------------
## COMPOSER
## -------------------------------------------------
composer-v:
	docker-compose exec php-cli /bin/bash -c "$(protected_dir) $(composer_version)"



## -------------------------------------------------
## GENERAL
## -------------------------------------------------
app-init:
	@echo "${GREEN}-------------------------------------------------------------------------------------------------------------------${NC}"
	@echo "${GREEN}Application had been initialized!      ${NC}"
	@echo "${GREEN}-------------------------------------------------------------------------------------------------------------------${NC}"
