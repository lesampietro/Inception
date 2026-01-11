COMPOSE = docker compose -f ./srcs/docker-compose.yml -p inception
SERVICES ?=
DATA_DIR ?= $(HOME)/data

build:
	@$(COMPOSE) build $(SERVICES)

all: secrets create-dirs
	$(COMPOSE) up -d $(SERVICES)

create-dirs:
	@mkdir -p $(DATA_DIR)/mariadb
	@mkdir -p $(DATA_DIR)/wordpress

secrets:
	@if [ ! -d secrets ]; then mkdir -p secrets; fi
	@if ! command -v openssl >/dev/null 2>&1; then echo "Error: openssl is not installed." >&2; exit 1; fi
	@if [ ! -f secrets/db_root_password.txt ]; then openssl rand -base64 32 > secrets/db_root_password.txt; fi
	@if [ ! -f secrets/db_password.txt ]; then openssl rand -base64 32 > secrets/db_password.txt; fi
	@if [ ! -f secrets/credentials.txt ]; then openssl rand -base64 32 > secrets/credentials.txt; fi
	@chmod 600 secrets/*.txt

down:
	@$(COMPOSE) down

clean:
	$(COMPOSE) down --rmi all --volumes --remove-orphans

prune:
	@docker system prune -f
	@docker volume prune -f

fclean: clean
	@sudo rm -rf $(DATA_DIR)
	@rm -rf secrets

re: fclean all

.PHONY: all re down clean create-dirs secrets fclean build prune