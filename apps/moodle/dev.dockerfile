FROM moodlehq/moodle-php-apache:8.2-buster

# Install additional dependencies required by the PHP extensions
RUN apt-get update \
    && apt-get install -y  \
    wget unzip tar