# Watchtower



## A propos

Watchtower est un conteneur qui va vous permettre de maintenir à jour automatiquement l'ensemble de vos conteneurs.



Lien vers l'image : https://hub.docker.com/r/containrrr/watchtower

Lien vers la documentation :  https://containrrr.dev/watchtower/



## Le fichier de configuration docker-compose

Pour celles et ceux souhaitant créer le conteneur via la saisie d'un stack dans Portainer, voici le détail du fichier de configuration utilisé

```yaml
version: "3.8"
services:
  watchtower:
    image: containrrr/watchtower:latest
    container_name: watchtower
    labels:
      - deunhealth.restart.on.unhealthy=true
      - diun.enable=true
    environment:
      - TZ=Europe/Paris
      - WATCHTOWER_CLEANUP=true
      - WATCHTOWER_LABEL_ENABLE=true
      - DOCKER_CONFIG=/config
      - WATCHTOWER_SCHEDULE=0 0 23 * * * # Pour vérification tous les jours à 23h00 
      - WATCHTOWER_ROLLING_RESTART=true
      - WATCHTOWER_TIMEOUT=30s
      - WATCHTOWER_NOTIFICATIONS=email
      - WATCHTOWER_NOTIFICATION_EMAIL_SUBJECTTAG="[ Watchtower-my NAS ]"
      - WATCHTOWER_NOTIFICATION_EMAIL_FROM=adresse.email@gmail.com
      - WATCHTOWER_NOTIFICATION_EMAIL_TO=adresse.email@gmail.com
      - WATCHTOWER_NOTIFICATION_EMAIL_SERVER=smtp.gmail.com
      - WATCHTOWER_NOTIFICATION_EMAIL_SERVER_PORT=587
      - WATCHTOWER_NOTIFICATION_EMAIL_SERVER_USER=adresse.email@gmail.com
      - WATCHTOWER_NOTIFICATION_EMAIL_SERVER_PASSWORD=mon-mot-de-passe
      - WATCHTOWER_NOTIFICATION_EMAIL_DELAY=2
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /home/pi/docker-data/watchtower/config/:/config/
    restart: unless-stopped
```

Pour créer le conteneur et le lancer

````bash
sudo docker-compose up -d
````



