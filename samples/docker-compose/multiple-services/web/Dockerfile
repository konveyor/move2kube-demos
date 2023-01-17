FROM registry.access.redhat.com/ubi8/php-74:latest
COPY . /var/www/html/
COPY site.conf /etc/httpd/conf.d/
EXPOSE 8082
CMD ["httpd", "-D", "FOREGROUND"]
