FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    cron \
    postgresql-client \
    libpq-dev \
    git \
    zip \
    unzip \
    libz-dev \
    libssl-dev \
    libicu-dev \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && docker-php-ext-install pdo pdo_pgsql intl \
    && pecl install mongodb-1.20.0 \
    && docker-php-ext-enable mongodb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/backend

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . .

RUN composer install --no-dev --no-scripts --optimize-autoloader --classmap-authoritative

RUN chown -R www-data:www-data /var/www/backend \
    && find /var/www/backend -type d -exec chmod 755 {} \; \
    && find /var/www/backend -type f -exec chmod 644 {} \;

CMD ["php-fpm"]

EXPOSE 9000