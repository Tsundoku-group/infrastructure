FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    cron \
    vim \
    postgresql-client \
    libpq-dev \
    git \
    zip \
    unzip \
    dnsutils \
    libz-dev \
    libssl-dev \
    && pecl install redis \
    && infrastructure-php-ext-enable redis \
    && infrastructure-php-ext-install pdo pdo_pgsql \
    && pecl install mongodb-1.20.0 \
    && infrastructure-php-ext-enable mongodb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/backend

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . .

RUN composer install

RUN chown -R www-data:www-data /var/www/backend \
    && find /var/www/backend -type d -exec chmod 755 {} \; \
    && find /var/www/backend -type f -exec chmod 644 {} \;

CMD ["php-fpm"]

EXPOSE 9000