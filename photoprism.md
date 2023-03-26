# Installation de Photoprism

## A propos

PhotoPrism est une application vous permettant de consulter, organiser et partager vos photos ainsi que vidéos. Elles disposent de fonctionnalités classiques comme la création d'albums et d'autres plus innovantes comme la détection de doublons, la géolocalisation des photos (via les coordonnées GPS contenues dans les EXIF) ainsi que l'ajout automatique de mots clefs via la technologie TenserFlow de Google. 

Afin de gérer une volumétrie importante de photos, j'ai fait le choix d'associer PhotoPrism à MariaDB qui est un système de gestion de base de données édité sous licence GPL. Il s'agit d'un fork communautaire de MySQL.

Enfin, pour faciliter l'administration de MariaDB, j'ai associé cette dernière à PhpMyAdmin



## Tutoriel vidéos

[Lien vers la vidéo](https://youtu.be/Tgg1tN3BGpk)



## Le fichier de configuration docker-compose

Pour celles et ceux souhaitant créer le conteneur via la saisie d'un stack dans Portainer, voici le détail du fichier de configuration utilisé

```yaml
version: "3.8"

services:

  photoprism-chris:
    container_name: photoprism-chris
    image: photoprism/photoprism:latest
    labels:
      - deunhealth.restart.on.unhealthy=true
      - diun.enable=true
      - com.centurylinklabs.watchtower.enable=true
    environment:
      - PHOTOPRISM_ADMIN_PASSWORD=password # Votre mot de passe admin si vous desactiver le mode public
      - PHOTOPRISM_DEBUG=false # Pour basculer en mode debuggage
      - PHOTOPRISM_PUBLIC=false # Pour désactiver l'accès par mot de passe
      - PHOTOPRISM_READONLY=false # Si vrai, bascule le répertoire originals en lecture seule, ce qui restreint les fonctionnalités
      - PHOTOPRISM_UPLOAD_NSFW=true
      - PHOTOPRISM_DETECT_NSFW=false
      - PHOTOPRISM_EXPERIMENTAL=true # Permet d'utiliser des fonctionnalités expérimentales
      - PHOTOPRISM_SITE_URL=http://localhost:2343 # URL d'accès
      - 'PHOTOPRISM_SITE_TITLE=PhotoPrism de Christophe'
      - 'PHOTOPRISM_SITE_CAPTION=Browse Your Life'
      - 'PHOTOPRISM_SITE_DESCRIPTION=bla bla'
      - 'PHOTOPRISM_SITE_AUTHOR=Christophe'
      - PHOTOPRISM_HTTP_HOST=0.0.0.0
      - PHOTOPRISM_HTTP_PORT=2343
      - PHOTOPRISM_SETTINGS_HIDDEN=false # Pour permettre de cacher l'accès aux paramétrages
      - PHOTOPRISM_DATABASE_DRIVER=mysql
      - PHOTOPRISM_DATABASE_DSN=photoprism:mySqlPhotoprismPwd@tcp(photoprism-db:3307)/photoprism-christophe?charset=utf8mb4,utf8&parseTime=true
      - PHOTOPRISM_SIDECAR_JSON=true # Creer automatiquement un fichier JSON pour chaque photo grâce à Exiftool
      - PHOTOPRISM_SIDECAR_YAML=true # Creer automatiquement un fichier YAML contenant les mots clefs pour chaque photo
      - PHOTOPRISM_THUMB_FILTER=lanczos # blackman, lanczos, cubic, linear (filtre pour la création des vignettes, du meilleur au pire)
      - PHOTOPRISM_THUMB_UNCACHED=true # Pour creer les vignettes à la demande
      - PHOTOPRISM_THUMB_SIZE=1024 # Taille max des vignettes créés par defaut (default 2048, min 720, max 7680)
      - PHOTOPRISM_THUMB_SIZE_UNCACHED=1024 # Taille max des vignettes créés à la demande (default 7680, min 720, max 7680)
      - PHOTOPRISM_JPEG_SIZE=1024 # Taille max en pixels pour les images RAW converties (720-30000)
      - PHOTOPRISM_JPEG_QUALITY=92 # Mettre 95 pour des vignettes de hautes qualités (25-100)
      - PHOTOPRISM_DARKTABLE_PRESETS=false # Use darktable presets (disables concurrent raw to jpeg conversion)
    volumes:
      - /path/to/media/photos/photoprism-christophe/import:/photoprism/import # Repertoire d'import
      - /path/to/media/photos/photoprism-christophe/originals:/photoprism/originals # Répertoire où seront stockées les photos importées
      - /path/to/docker-data/photoprism-christophe/storage:/photoprism/storage # Répertoire pour les paramétrages, les index, les miniatures
    ports:
      - 2343:2343
    security_opt:
      - seccomp:unconfined
      - apparmor:unconfined
    restart: unless-stopped
    networks:
      - christophe_frontend
      - christophe_backend

  photoprism-db:
    container_name: photoprism-db
    image: mariadb:10.5
    labels:
      - deunhealth.restart.on.unhealthy=true
      - diun.enable=true
      - com.centurylinklabs.watchtower.enable=true
    environment:
      - MYSQL_ROOT_PASSWORD=mySqlRootPwd
      - MYSQL_USER=photoprism
      - MYSQL_PASSWORD=mySqlPhotoprismPwd
      - MYSQL_DATABASE=photoprism-liliya
    volumes:
      - /path/to/docker-data/photoprism-db/var/lib/mysql:/var/lib/mysql
    ports:
      - 3307:3307
    command: mysqld --port=3307 --transaction-isolation=READ-COMMITTED --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci --max-connections=512 --innodb-rollback-on-timeout=OFF --innodb-lock-wait-timeout=50
    restart: unless-stopped
    networks:
      - christophe_backend

  photoprism-liliya:
    container_name: photoprism-liliya
    image: photoprism/photoprism:latest
    labels:
      - deunhealth.restart.on.unhealthy=true
      - diun.enable=true
      - com.centurylinklabs.watchtower.enable=true
    environment:
      - PHOTOPRISM_ADMIN_PASSWORD=password # Votre mot de passe admin si vous desactiver le mode public
      - PHOTOPRISM_DEBUG=false # Pour basculer en mode debuggage
      - PHOTOPRISM_PUBLIC=false # Pour désactiver l'accès par mot de passe
      - PHOTOPRISM_READONLY=false # Si vrai, bascule le répertoire originals en lecture seule, ce qui restreint les fonctionnalités
      - PHOTOPRISM_UPLOAD_NSFW=true
      - PHOTOPRISM_DETECT_NSFW=false
      - PHOTOPRISM_EXPERIMENTAL=true # Permet d'utiliser des fonctionnalités expérimentales
      - PHOTOPRISM_SITE_URL=http://localhost:2342 # URL d'accès
      - 'PHOTOPRISM_SITE_TITLE=PhotoPrism de Liliya'
      - 'PHOTOPRISM_SITE_CAPTION=Browse Your Life'
      - 'PHOTOPRISM_SITE_DESCRIPTION=bla bla'
      - 'PHOTOPRISM_SITE_AUTHOR=Liliya'
      - PHOTOPRISM_HTTP_HOST=0.0.0.0
      - PHOTOPRISM_HTTP_PORT=2342
      - PHOTOPRISM_SETTINGS_HIDDEN=false # Pour permettre de cacher l'accès aux paramétrages
      - PHOTOPRISM_DATABASE_DRIVER=mysql
      - PHOTOPRISM_DATABASE_DSN=photoprism:mySqlPhotoprismPwd@tcp(photoprism-db:3307)/photoprism-liliya?charset=utf8mb4,utf8&parseTime=true
      - PHOTOPRISM_SIDECAR_JSON=true # Creer automatiquement un fichier JSON pour chaque photo grâce à Exiftool
      - PHOTOPRISM_SIDECAR_YAML=true # Creer automatiquement un fichier YAML contenant les mots clefs pour chaque photo
      - PHOTOPRISM_THUMB_FILTER=lanczos # blackman, lanczos, cubic, linear (filtre pour la création des vignettes, du meilleur au pire)
      - PHOTOPRISM_THUMB_UNCACHED=true # Pour creer les vignettes à la demande
      - PHOTOPRISM_THUMB_SIZE=1024 # Taille max des vignettes créés par defaut (default 2048, min 720, max 7680)
      - PHOTOPRISM_THUMB_SIZE_UNCACHED=1024 # Taille max des vignettes créés à la demande (default 7680, min 720, max 7680)
      - PHOTOPRISM_JPEG_SIZE=1024 # Taille max en pixels pour les images RAW converties (720-30000)
      - PHOTOPRISM_JPEG_QUALITY=92 # Mettre 95 pour des vignettes de hautes qualités (25-100)
      - PHOTOPRISM_DARKTABLE_PRESETS=false # Use darktable presets (disables concurrent raw to jpeg conversion)
    volumes:
      - /path/to/media/photos/photoprism-liliya/import:/photoprism/import # Repertoire d'import
      - /path/to/media/photos/photoprism-liliya/originals:/photoprism/originals # Répertoire où seront stockées les photos importées
      - /path/to/docker-data/photoprism-liliya/storage:/photoprism/storage # Répertoire pour les paramétrages, les index, les miniatures
    ports:
      - 2342:2342
    security_opt:
      - seccomp:unconfined
      - apparmor:unconfined
    restart: unless-stopped
    networks:
      - christophe_frontend
      - christophe_backend

networks:
  christophe_frontend:
    external: true
  christophe_backend:
    external: true
```



## On se connecte sur notre conteneur Photoprism

http://<host-IP>:2342/photos ou 2343

