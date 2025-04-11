#!/bin/bash

# Générer le fichier .htpasswd avec les variables d'environnement
htpasswd -cb /etc/apache2/.htpasswd "${AUTH_USER}" "${AUTH_PASS}"

# S'assurer que les permissions sont correctes
chown -R www-data:www-data /var/www/html/stats
chown -R www-data:www-data /var/log/apache2

# Démarrer le service cron
service cron start

sleep 2

# Démarrer Apache en premier plan
exec apache2ctl -D FOREGROUND 