FROM php:7.4-cli-alpine

# MAKEFILE
# ------------------------------
# install Makefile (make utillity, required by some modules, ex.: xdebug)
RUN apk add --no-cache make

# XDEBUG with all dependencies
# ------------------------------
# install xdebug (requires make utillity !!!)
RUN apk add --no-cache autoconf g++ \
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


# ------------------------------
# ADD here more extensions you need....
# ------------------------------

# COMPOSER
# ------------------------------
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"

# install composer from composer image - already existing image
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

# PHP INI file
# -------------------------------------------------------------
RUN mv $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini

## CONFIG files
## -------------------------------------------------------------
#COPY ./php/conf.d /usr/local/etc/php/conf.d

# ADD PERMISSIONS FOR USER "app"
# ------------------------------
RUN addgroup -g 1000 app && adduser -u 1000 -G app -s /bin/sh -D app

# WORKING DIRECTORY
# set working dir as /myapp instead of default working dir
# ------------------------------
WORKDIR /myapp

# SET USER "app"
# ------------------------------
USER app
