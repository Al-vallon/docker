FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y goaccess apache2 apache2-utils cron && \
    mkdir -p /var/www/html/stats && \
    mkdir -p /var/log/apache2 && \
    mkdir -p /var/log/nginx && \
    rm -f /var/log/nginx/access.log /var/log/nginx/error.log && \
    touch /var/log/nginx/access.log /var/log/nginx/error.log && \
    chown -R www-data:www-data /var/www/html/stats && \
    chown -R www-data:www-data /var/log/apache2 && \
    chown -R www-data:www-data /var/log/nginx && \
    chmod 644 /var/log/nginx/access.log /var/log/nginx/error.log && \
    htpasswd -cb /etc/apache2/.htpasswd admin admin && \
    chown www-data:www-data /etc/apache2/.htpasswd && \
    chmod 644 /etc/apache2/.htpasswd && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

COPY goaccess.conf /etc/goaccess/goaccess.conf
COPY apache2.conf /etc/apache2/sites-available/000-default.conf
COPY ports.conf /etc/apache2/ports.conf
COPY crontab.txt /etc/cron.d/goaccess-cron

RUN chmod 0644 /etc/cron.d/goaccess-cron && \
    crontab /etc/cron.d/goaccess-cron && \
    a2enmod auth_basic && \
    a2dissite 000-default && \
    a2ensite 000-default && \
    sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf

# crrer le fichier 
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
