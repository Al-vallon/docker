FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y goaccess apache2 apache2-utils cron && \
    mkdir -p /var/www/html/stats && \
    chown -R www-data:www-data /var/www/html/stats

COPY goaccess.conf /etc/goaccess/goaccess.conf
COPY crontab.txt /etc/cron.d/goaccess-cron
COPY .htpasswd /etc/apache2/.htpasswd

RUN chmod 0644 /etc/cron.d/goaccess-cron && \
    crontab /etc/cron.d/goaccess-cron && \
    a2enmod auth_basic && \
    a2enmod autoindex && \
    sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf && \
    echo 'AuthType Basic\nAuthName "Restricted"\nAuthUserFile /etc/apache2/.htpasswd\nRequire valid-user' > /var/www/html/stats/.htaccess


CMD ["/bin/bash", "-c", "service cron start && apache2ctl -D FOREGROUND"]
