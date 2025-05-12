# ========== CONFIG ==========
ENV_FILE=./.env
COMPOSE=docker compose
COMPOSE_DEV_FILES=-f ./compose/dev/docker-compose.yaml -f ./compose/dev/docker-compose.override.yaml

PHP_SERVICE=php
NEXTJS_SERVICE=nextjs

# ========== AIDE ==========
help: ## Affiche la liste des commandes disponibles
	@echo "Commandes disponibles :"
	@grep -E '^[a-zA-Z_-]+:.*?##' Makefile | awk 'BEGIN {FS = ":.*?##"}; {printf "  \033[36m%-25s\033[0m %s\n", $$1, $$2}'

# ========== DOCKER COMPOSE ==========
build: ## Build les containers sans cache
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) build --no-cache

start: ## Démarre les services existants
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) start

stop: ## Stoppe les services
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) stop

up: ## Démarre les containers en détache
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) up -d

down: ## Stoppe et supprime les containers
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) down

restart: ## Redémarre tous les services
	$(MAKE) down
	$(MAKE) up

docker-ps: ## Liste les containers actifs
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) ps

images: ## Liste les images Docker
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) images

logs: ## Affiche les logs
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) logs -f

# ========== ACCESS CONTAINERS ==========
php-bash: ## Accède au shell du container PHP
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) bash

composer-bash: ## Accède au container PHP avec bash
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) bash

nextjs-bash: ## Accède au shell du container Next.js
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(NEXTJS_SERVICE) bash

# ========== COMPOSER ==========
composer-install: ## Lance composer install dans PHP
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) composer install

composer-require: ## Installe un package via composer require
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) composer require $(package)

# ========== SYMFONY ==========
make-entity: ## Crée une entité Symfony
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) php bin/console make:entity $(entity)

make-migration: ## Crée une migration Doctrine
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) php bin/console make:migration

migrate: ## Exécute les migrations Doctrine
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) php bin/console doctrine:migrations:migrate --no-interaction

cache-clear: ## Vide le cache Symfony
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) php bin/console cache:clear

debug-router: ## Affiche les routes Symfony
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) php bin/console debug:router

# ========== DOCTRINE ==========
create-database: ## Crée la BDD si inexistante
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) php bin/console doctrine:database:create --if-not-exists

drop-database: ## Supprime la BDD
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) php bin/console doctrine:database:drop --force

create-schema: ## Crée le schéma Doctrine
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) php bin/console doctrine:schema:create

update-schema: ## Met à jour le schéma Doctrine
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) php bin/console doctrine:schema:update --force

validate-schema: ## Valide le schéma Doctrine
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) php bin/console doctrine:schema:validate

fixtures: ## Charge les fixtures Doctrine
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(PHP_SERVICE) php bin/console doctrine:fixtures:load --no-interaction

# ========== NEXTJS ==========
npm-install: ## Installe les dépendances npm
	$(COMPOSE) --env-file $(ENV_FILE) $(COMPOSE_DEV_FILES) exec $(NEXTJS_SERVICE) npm install

# ========== KUBERNETES ==========
kube-apply: ## Applique tous les fichiers kube
	kubectl apply -f kubernetes/

kube-pods: ## Liste les pods en cours
	kubectl get pods -A