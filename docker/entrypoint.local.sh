#!/bin/bash

if [ ! -f "vendor/autoload.php" ]; then
    composer install --no-progress --no-interaction
fi

if [ ! -f ".env" ]; then
    echo "Creating env file for env $APP_ENV"
    cp .env.example .env
else
    echo "env file exists."
fi
php artisan key:generate
php artisan migrate
php artisan optimize clear
php artisan view:clear
php artisan route:clear

php-fpm -D
nginx -g "daemon off;"