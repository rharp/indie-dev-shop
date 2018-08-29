DOCKER_COMPOSE_FILE := docker-compose.yml

init: composer-install docker-rebuild drupal-init config-init config-import

composer-install:
	docker run --rm --interactive --tty --volume ${PWD}:/app \
	mobomo/composer install --ignore-platform-reqs --no-interaction;

docker-rebuild:
	docker-compose -f ${DOCKER_COMPOSE_FILE} up -d --build
	docker-compose -f ${DOCKER_COMPOSE_FILE} ps
	@sleep 10

docker-status:
	docker-compose -f ${DOCKER_COMPOSE_FILE} ps

docker-start:
	docker-compose -f ${DOCKER_COMPOSE_FILE} up -d
	docker-compose -f ${DOCKER_COMPOSE_FILE} ps
	@sleep 10

docker-stop:
	docker-compose -f ${DOCKER_COMPOSE_FILE} down

docker-destroy:
	docker-compose -f ${DOCKER_COMPOSE_FILE} down -v

drupal-init:
	scripts/drush site-install minimal --account-pass=admin --yes

drupal-upgrade:
	composer update drupal/core --with-dependencies

config-init:
	@if [ -e ./config/sync/system.site.yml ]; then \
		echo "Config found. Processing setting uuid..."; \
		cat ./config/sync/system.site.yml | \
		grep uuid | tail -c +7 | head -c 36 | \
		docker exec -i php sh -c "/indie-dev-shop/vendor/bin/drush \
		--root=/indie-dev-shop/web config-set -y system.site uuid - ";\
	else \
		echo "Config is empty. Skipping uuid init..."; \
	fi;

config-import:
	@if [ -e ./config/sync/system.site.yml ]; then \
		scripts/drush config-import sync --yes;  \
	else \
		echo "Config is empty. Skipping import..."; \
	fi;

destroy: docker-destroy composer-purge
	sudo rm -rf ./web/sites/default/files/*

rebuild: destroy init

composer-purge:
	sudo rm -rf ./web/core/*
	sudo rm -rf ./web/libraries/*
	sudo rm -rf ./web/modules/contrib/*
	sudo rm -rf ./web/profiles/contrib/*
	sudo rm -rf ./web/themes/contrib/*
	sudo rm -rf ./drush/contrib/*
	sudo rm -rf ./vendor/*

config-export:
	./scripts/drush config-export --yes

config-refresh: config-init config-import
