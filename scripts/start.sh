#!/bin/bash

cd /var/www
chmod 777 -R aws-test-api

cd aws-test-api

composer install
composer dump-autoload

php artisan config:clear
php artisan cache:clear
php artisan view:clear

systemctl restart supervisor
php artisan queue:restart
