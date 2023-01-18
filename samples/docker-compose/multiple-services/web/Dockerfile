# FROM registry.access.redhat.com/ubi8/php-74:latest
FROM php:7-apache
COPY . /var/www/html/
RUN sed -i 's/80/8080/g' /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf
EXPOSE 8080
