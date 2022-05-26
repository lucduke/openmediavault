# Installation de DuckDNS

## A propos



## Tutoriel vidéos

[Lien](https://youtu.be/ZzcffHMyUmQ)



## Le fichier de configuration docker-compose

Pour celles et ceux souhaitant créer le conteneur via la saisie d'un stack dans Portainer, voici le détail du fichier de configuration utilisé

```yaml
version: "3.8"

services:

  duckdns:
    container_name: duckdns
    image: ghcr.io/linuxserver/duckdns:amd64-latest
    labels:
      - deunhealth.restart.on.unhealthy=true
      - diun.enable=true
      - com.centurylinklabs.watchtower.enable=true
    environment:
      - PUID=0 #ID root
      - PGID=0 #GID root
      - TZ=Europe/Paris
      - SUBDOMAINS=yourSubDomain
      - TOKEN=yourToken
    volumes:
      - /path/to/docker-data/duckdns/config:/config
    restart: unless-stopped
    networks:
      - christophe_frontend

networks:
  christophe_frontend:
    # A ajouter si ce docker network existe deja
    #external: true
```

Pour créer le conteneur et le lancer

````bash
sudo docker-compose up -d
````
