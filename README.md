Ce projet met en place une solution de monitoring des logs Nginx en utilisant GoAccess. Il est composé de deux services principaux configurés avec Docker Compose:

Architecture
Service Nginx (nginx_proxy)

Serveur web qui reçoit les requêtes HTTP
Agit comme proxy inverse vers le service GoAccess
Expose le port 8081 à l'extérieur
Les logs d'accès Nginx sont partagés avec GoAccess via un volume
Service GoAccess (goaccess_viewer)

Outil d'analyse de logs en temps réel

Génère des rapports HTML à partir des logs Nginx
Protégé par authentification basic (username/password)
Expose le port 8082 à l'extérieur

Fonctionnalités principales
Monitoring des logs en temps réel: GoAccess analyse les logs Nginx toutes les minutes (via cron)
Interface web sécurisée: Accès au tableau de bord GoAccess protégé par mot de passe
Configuration personnalisable: Les credentials sont définis par variables d'environnement
Haute disponibilité: Les services sont configurés avec healthchecks et redémarrage automatique

Volumes et persistance
Le projet utilise plusieurs volumes Docker pour assurer la persistance et le partage des données:

shared-logs: Logs Nginx partagés entre les conteneurs
goaccess-reports: Stockage des rapports générés par GoAccess
nginx-config et apache-config: Configurations des serveurs web

Accès aux services
Interface Nginx: 
```
http://localhost:8081
```
Tableau de bord GoAccess: 
```
http://localhost:8082 (identifiants définis dans .env)
```
Configuration
Les paramètres d'authentification sont stockés dans le fichier .env:

AUTH_USER: Nom d'utilisateur pour l'accès à GoAccess (par défaut: admin)
AUTH_PASS: Mot de passe pour l'accès à GoAccess (par défaut: admin)

Ce projet représente une solution complète pour la surveillance et l'analyse des logs Nginx avec une interface utilisateur intuitive et sécurisée.

Location des logs:
Nginx logs:

Access log: 
```
docker exec nginx_proxy cat /var/log/nginx/access.log
```
Error log:
```
docker exec nginx_proxy cat /var/log/nginx/error.log
```

Apache logs (in GoAccess container):

```
Access log: ${APACHE_LOG_DIR}/access.log
Error log: ${APACHE_LOG_DIR}/error.log
```

Accéder aux logs Nginx depuis votre terminal
Pour accéder aux logs Nginx /var/log/nginx/access.log à partir de votre terminal Windows, vous pouvez utiliser Docker CLI. Voici comment procéder :

1. Afficher les logs directement

```
docker exec nginx_proxy cat /var/log/nginx/access.log.
```
Cela affiche le contenu du fichier de logs dans votre terminal.

2. Suivre les logs en temps réel

```
docker exec nginx_proxy tail -f /var/log/nginx/access.log
```
Cette commande vous permet de voir les nouvelles entrées de log au fur et à mesure qu'elles sont ajoutées.

3. Copier les logs sur votre machine locale
```
docker cp nginx_proxy:/var/log/nginx/access.log ./nginx-access.log
```

Cette commande copie le fichier de logs du conteneur vers votre répertoire courant.

4. Entrer dans le conteneur pour explorer les logs
```
docker exec -it nginx_proxy bash

```
Une fois dans le conteneur, vous pouvez naviguer et examiner les fichiers de logs avec des commandes Linux standard :

```
cd /var/log/nginx
ls -la
cat access.log
grep "404" access.log
```
Assurez-vous que le conteneur nginx_proxy est en cours d'exécution pour utiliser ces commandes.
