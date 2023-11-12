# Use the official PHP 8.0 FPM image as a base
FROM php:8.0-apache

# Install additional dependencies required by the PHP extensions
RUN apt-get update \
    && apt-get install -y  \
    wget unzip tar \
    libfreetype-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    libxml2-dev \
    libicu-dev \
    zlib1g-dev \
    libcurl4-openssl-dev \
    libonig-dev

# Download and install the PHP extension installer script
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# Make the script executable
RUN chmod +x /usr/local/bin/install-php-extensions

# Install the required PHP extensions using the script
RUN install-php-extensions \
        gd \
        iconv \
        mbstring \
        curl \
        soap \
        ctype \
        zip \
        dom \
        xml \
        xmlreader \
        intl \
        json \
        exif \
        opcache \
        mysqli

# Clean up to reduce the image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# COPY nginx.conf /etc/nginx/nginx.conf
COPY php.ini /usr/local/etc/php/php.ini

# Set the working directory
WORKDIR /var/www/html

# RUN wget -O moodle-latest-403.tgz "https://download.moodle.org/download.php/stable403/moodle-latest-403.tgz"
# RUN file test moodle-latest-403.tgz

# Create Moodle data directory
RUN mkdir -p /var/www/moodledata

# Set permissions for the Moodle directory
RUN chown -R root:www-data /var/www/html \
    && chown -R www-data: /var/www/moodledata \
    && chmod -R 700 /var/www/html \
    && chmod -R 755 /var/www/moodledata

USER root

# Expose port 9000 and start php-fpm server
EXPOSE 80