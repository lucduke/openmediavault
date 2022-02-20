# Heimdall



## A propos

Heimdall est un portail web facilitant l'accès aux différents services installés sur son serveur



Lien vers le projet : https://heimdall.site

Lien vers l'image : https://hub.docker.com/r/linuxserver/heimdall/ 



## Le fichier de configuration docker-compose

Pour celles et ceux souhaitant créer le conteneur via la saisie d'un stack dans Portainer, voici le détail du fichier de configuration utilisé

```dockerfile
version: "3.8"

services:
  heimdall:
    container_name: heimdall
    image: lscr.io/linuxserver/heimdall:latest
    labels:
      - deunhealth.restart.on.unhealthy=true
      - diun.enable=true
    environment:
      - PUID=998 #id admin 
      - PGID=100 #gid users
      - TZ=Europe/Paris
    volumes:
      - /path/to/docker-data/heimdall/config:/config
    ports:
      - 5080:80
      - 5443:443
    restart: unless-stopped
    networks:
      - christophe_frontend

networks:
  christophe_frontend:
    external: true
```

Pour créer le conteneur et le lancer

````bash
sudo docker-compose up -d
````



