# Installation de Jellyfin

## A propos1

Jellyfin est une media center, gratuit et open source, concurrent de Plex et Emby dont il est un fork



## Tutoriel vidéos

[Lien vers la vidéo](https://youtu.be/4a_vrxQEHR0)



## Le fichier de configuration docker-compose

Pour celles et ceux souhaitant créer le conteneur via la saisie d'un stack dans Portainer, voici le détail du fichier de configuration utilisé

```yaml
version: "3.8"

services:

  jellyfin:
    container_name: jellyfin
    image: ghcr.io/linuxserver/jellyfin:latest
    labels:
      - deunhealth.restart.on.unhealthy=true
      - diun.enable=true
      - com.centurylinklabs.watchtower.enable=true

    environment:
      - PUID=0 #id root
      - PGID=0 #gid root
      - TZ=Europe/Paris
      - UMASK_SET=022
    volumes:
      - /path/to/media/videos/series:/data/tvshows
      - /path/to/media/videos/films:/data/movies
      - /path/to/media/videos:/data/other_media
      - /path/to/docker-data/jellyfin/config:/config
    ports:
      - 8096:8096/tcp # http webui
      - 8920:8920/tcp # https webui
      - 7359:7359/udp # allows clients to discover Jellyfin on the local network
      - 1900:1900/udp # service discovery used by DNLA and clients
    restart: unless-stopped
    networks:
      - christophe_frontend

networks:
  christophe_frontend:
    # A ajouter si ce docker network existe deja
    #external: true
```



## On se connecte sur notre conteneur Jellyfin

http://<host-IP>:8096

