run:
	docker-compose up -d

install-webapp: run
	docker-compose exec php composer install
	docker-compose exec php php artisan key:generate

db-backup:
	scripts/backup.sh

e-web:
	docker-compose exec php bash

test:
	docker-compose exec php ./vendor/bin/phpunit

clear:
	docker-compose exec php php artisan config:clear
	docker-compose exec php php artisan route:clear
	docker-compose exec php php artisan cache:clear

optimize:
	docker-compose exec php php artisan optimize

deploy:
	docker-compose exec php php artisan down
	git pull origin master
	docker-compose exec php php artisan migrate
	make clear
	docker-compose exec php php artisan up

