FROM php:8.0-fpm-alpine

# MAKEFILE
# ------------------------------
# install Makefile (make utillity, required by some modules, ex.: xdebug)
RUN apk add --no-cache make

# XDEBUG with all dependencies
# ------------------------------
# install xdebug (requires make utillity !!!)
RUN apk add --no-cache autoconf g++ linux-headers \
    && pecl install xdebug \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable xdebug

# ZIP
# ------------------------------
RUN apk add --no-cache zip libzip-dev
RUN docker-php-ext-configure zip
RUN docker-php-ext-install zip

# MYSQL
# ------------------------------
RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN docker-php-ext-enable pdo_mysql

# PHP INI file
# -------------------------------------------------------------
RUN mv $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini

# CONFIG files
# -------------------------------------------------------------
COPY ./php/conf.d/php.ini /usr/local/etc/php/conf.d/php.ini
COPY ./php/conf.d/timeouts.ini /usr/local/etc/php/conf.d/timeouts.ini
COPY ./php/conf.d/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY ./php/conf.d/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# SET working dir as /myapp instead of default working dir
# -------------------------------------------------------------
WORKDIR /myapp

# SET docker-access-host for all types of OS: Win, Linux, Mac
# https://github.com/bufferings/docker-access-host
# -------------------------------------------------------------
COPY ./php-fpm/entrypoint.sh /usr/local/bin/docker-php-entrypoint
RUN chmod +x /usr/local/bin/docker-php-entrypoint
