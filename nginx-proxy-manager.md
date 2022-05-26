# Installation de Nginx-Proxy-Manager

## A propos

NGINX Proxy Manager va nous faciliter l'administration des règles de routage du reverse proxy éponyme. Ainsi, nous pourrons facilement configurer les règles associant nos services (Airsonic, Jellyfin ...) à des URLs personnalisées



## Tutoriel vidéos

[Lien vers la vidéo](https://youtu.be/qtWU9tgtnU0)



## Le fichier de configuration docker-compose

Pour celles et ceux souhaitant créer le conteneur via la saisie d'un stack dans Portainer, voici le détail du fichier de configuration utilisé

```yaml
version: "3.8"

networks:
  frontend:
    # A ajouter si ce docker network existe deja
    # external: true

services:

  nginx-proxy-manager:
    container_name: nginx-proxy-manager
    image: jlesage/nginx-proxy-manager:latest
    labels:
      - deunhealth.restart.on.unhealthy=true
      - diun.enable=true
      - com.centurylinklabs.watchtower.enable=true
    environment:
      - USER_ID=0 #id root
      - GROUP_ID=0 #gid root
      - UMASK=022 #rwxr-xr-x
      - CLEAN_TMP_DIR=1 #All files in the /tmp directory are delete during the container startup 
    volumes:
      - /path/to/docker-data/nginx-proxy-manager/config:/config
      - /etc/localtime:/etc/localtime:ro
    ports:
      - 4443:4443/tcp
      - 8080:8080/tcp
      - 8181:8181/tcp
    restart: unless-stopped
    networks:
      - frontend
```

Pour créer le conteneur et le lancer

````bash
sudo docker-compose up -d
````



## On se connecte sur notre conteneur nginx-proxy-manager

http://<host-IP>:8181

