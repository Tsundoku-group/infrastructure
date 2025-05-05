# ========== CONFIG ==========
ENV_FILE=./.env
COMPOSE=docker compose
COMPOSE_DEV_FILES=-f ./compose/dev/docker-compose.yaml -f ./compose/dev/docker-compose.override.yaml

PHP_SERVICE=php
NEXTJS_SERVICE=nextjs

# ========== DOCKER COMPOSE ==========
build:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) build --no-cache

start:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) start

stop:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) stop

up:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) up -d

down:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) down

restart:
	$(MAKE) down
	$(MAKE) up

docker-ps:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) ps

images:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) images

logs:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) logs -f

# ========== ACCESS CONTAINERS ==========
php-bash:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) bash

composer-bash:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) bash

nextjs-bash:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(NEXTJS_SERVICE) bash

# ========== COMPOSER ==========
composer-install:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) composer install

composer-require:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) composer require $(package)

# ========== SYMFONY ==========
make-entity:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) php bin/console make:entity $(entity)

make-migration:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) php bin/console make:migration

migrate:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) php bin/console doctrine:migrations:migrate --no-interaction

cache-clear:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) php bin/console cache:clear

debug-router:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) php bin/console debug:router

# ========== DOCTRINE ==========
create-database:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) php bin/console doctrine:database:create --if-not-exists

drop-database:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) php bin/console doctrine:database:drop --force

create-schema:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) php bin/console doctrine:schema:create

update-schema:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) php bin/console doctrine:schema:update --force

validate-schema:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) php bin/console doctrine:schema:validate

fixtures:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) php bin/console doctrine:fixtures:load --no-interaction

# ========== NEXTJS ==========
npm-install:
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(NEXTJS_SERVICE) npm install