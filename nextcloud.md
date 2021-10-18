# Installation de Nextcloud & MariaDB

**Nextcloud** est un logiciel libre d'hébergement de fichiers et une plateforme de collaboration. Parmi ses nombreuses fonctionnalités, on retiendra notamment :

- La synchronisation de fichiers entre différents ordinateurs, tablettes et smartphones.
- Le partage de fichiers entre utilisateurs nextcloud ou utilisateurs externes.
- La gestion de calendrier, tâches, contacts via CalDAV
- Les conférences privées audio/vidéo avec partage d'écran.
- Un éditeur de texte en ligne (proposant la coloration syntaxique) ainsi qu'une édition en ligne de documents avec l'intégration de OnlyOffice
- Une cisionneuse de documents en ligne (PDF, OpenDocument).
- La gestion de galerie d'images multiformats (jpg, cr2, img…).
- ...

Dans cet article, nous verrons comment y accéder en HTPPS via le reverse proxy NGINX Proxy Manager



## Tutoriel vidéo

[Lien vers la vidéo Youtube](https://youtu.be/h-oINxS8I6w)



## Pré-requis

Avoir installé docker et docker-compose sur son serveur. Pour vérifier, vous pouvez saisir les commandes suivantes

```bash
docker --version
docker-compose --version
```

Il faut également disposer d'un répertoire où stocker les volumes docker. Dans mon cas, je crée un répertoire docker-data dans le dossier home de mon utilisateur

```bash
mkdir -p ~/docker-data
```

Enfin, comme cette instance Nextcloud sera accessible via https, il faut installer Nginx Proxy Manager (cf. le service décrit dans le fichier docker-compose ci-après)



## La configuration du fichier docker-compose

On crée un fichier docker-compose.yml qui contient les éléments suivants :

````yaml
version: "3.8"

networks:
  frontend:
    # A ajouter si ce docker network existe deja dans un autre fichier docker-compose
    # external: true
  backend:


services:

  nginx-proxy-manager:
    container_name: nginx-proxy-manager
    environment:
      - USER_ID=1000 #id user
      - GROUP_ID=1000 #gid user
      - UMASK=022 #rwxr-xr-x
      - CLEAN_TMP_DIR=1 #All files in the /tmp directory are delete during the container startup
    image: jlesage/nginx-proxy-manager:latest
    ports:
      - 4443:4443/tcp
      - 8080:8080/tcp
      - 8181:8181/tcp
    restart: unless-stopped
    volumes:
      - ./nginx-proxy-manager/config:/config
      - /etc/localtime:/etc/localtime:ro
    networks:
      - frontend

  nextcloud-app:
    container_name: nextcloud-app
    environment:
      - MYSQL_PASSWORD=mysqlpwd
      - MYSQL_DATABASE=nextcloud
      - MYSQL_USER=nextcloud
      - MYSQL_HOST=nextcloud-db
      - OVERWRITEPROTOCOL=https #pour permettre le bon fonctionnement du client Windows/Linux
      - NEXTCLOUD_TRUSTED_DOMAINS=nextcloud.dukeofputeauxyt.duckdns.org
    image: nextcloud
    ports:
      - 8070:80
    restart: unless-stopped
    volumes:
      - ./nextcloud-app/var/www/html:/var/www/html
      - ./documents:/documents:ro #Lien vers un éventuel dossier en read only auquel on voudrait accéder depuis Nextcloud 
    networks:
      - frontend
      - backend

  nextcloud-db:
    container_name: nextcloud-db
    environment:
      - MYSQL_ROOT_PASSWORD=mysqlrootpwd
      - MYSQL_PASSWORD=mysqlpwd
      - MYSQL_DATABASE=nextcloud
      - MYSQL_USER=nextcloud
    image: mariadb
    command: --transaction-isolation=READ-COMMITTED --binlog-format=ROW --skip-innodb-read-only-compressed
    restart: unless-stopped
    volumes:
      - ./nextcloud-db/var/lib/mysql:/var/lib/mysql
    networks:
      - backend
````



## Déploiement du conteneur

````bash
sudo docker-compose up -d
````



## Configuration Nginx-Proxy-Manager

http://<hostname>:8181

Pour la 1ère connexion, utiliser le user / mot de passe ci-après :

user: admin@example.com
pwd: changeme



Pour la configuration de NGINX Proxy Manager, cf. le tutoriel vidéo



## Configuration de Nextcloud

http://<hostname>:8070

Pour la configuration de Nextcloud, cf. le tutoriel vidéo



## A propos

Lien vers l'image Nextcloud : https://hub.docker.com/_/nextcloud

Lien vers l'image MariaDB : https://hub.docker.com/_/mariadb

Lien vers l'image Nginx Proxy Manager : https://hub.docker.com/r/jlesage/nginx-proxy-manager

