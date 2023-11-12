FROM moodlehq/moodle-php-apache:8.2-buster

ARG UID
ARG GID

ENV UID=${UID}
ENV GID=${GID}

WORKDIR /var/www/html

# Fix permission issues in linux host machines
RUN addgroup -g ${GID} --system muser
RUN adduser -G muser --system -D -s /bin/sh -u ${UID} muser

RUN sed -i "s/user = www-data/user = muser/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = muser/g" /usr/local/etc/php-fpm.d/www.conf

# Install additional dependencies required by the PHP extensions
RUN apt-get update \
    && apt-get install -y  \
    wget unzip tar

USER muser