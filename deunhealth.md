# Deunhealth



## A propos

Deunhealth permet de redemarrer les conteneurs au statut unhealthy



Lien vers le projet : https://github.com/qdm12/deunhealth

Lien vers l'image : https://hub.docker.com/r/qmcgaw/deunhealth



## Le fichier de configuration docker-compose

Pour celles et ceux souhaitant créer le conteneur via la saisie d'un stack dans Portainer, voici le détail du fichier de configuration utilisé

```dockerfile
version: "3.8"

services:

  deunhealth:
    container_name: deunhealth
    labels:
      - deunhealth.restart.on.unhealthy=true
      - diun.enable=true
    environment:
      - LOG_LEVEL=info
      - HEALTH_SERVER_ADDRESS=127.0.0.1:9999
      - TZ=Europe/Paris
    image: qmcgaw/deunhealth:latest
    restart: unless-stopped
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    network_mode: none
```

Pour créer le conteneur et le lancer

````bash
sudo docker-compose up -d
````

Pour que deunhealth relance les conteneurs unhealthy, il faut ajouter le label "deunhealth.restart.on.unhealthy=true" dans la configuration du conteneur à surveiller

