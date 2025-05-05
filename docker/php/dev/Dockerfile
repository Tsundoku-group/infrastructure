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
    && docker-php-ext-enable redis \
    && docker-php-ext-install pdo pdo_pgsql \
    && pecl install mongodb-1.20.0 \
    && docker-php-ext-enable mongodb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/backend

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer install

CMD ["php-fpm"]