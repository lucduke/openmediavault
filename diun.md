# Diun



## A propos

Diun est une application permettant de recevoir des notifications (mail, Telégram, Discord ...) lorsque qu'une image Docker que vous utilisez est mise à jour.



Lien vers le projet : https://github.com/crazy-max/diun

Lien vers l'image : https://hub.docker.com/r/crazymax/diun/



## Le fichier de configuration docker-compose

Pour celles et ceux souhaitant créer le conteneur via la saisie d'un stack dans Portainer, voici le détail du fichier de configuration utilisé

```yaml
version: "3.8"

services:

  diun:
    container_name: diun
    image: crazymax/diun:latest
    labels:
      - deunhealth.restart.on.unhealthy=true
      - diun.enable=true
      - diun.watch_repo=true
    command: serve
    environment:
      - TZ=Europe/Paris
      - LOG_LEVEL=info
      - LOG_JSON=false
      - DIUN_WATCH_WORKERS=20
      - DIUN_WATCH_SCHEDULE=0 20 * * * #Se lance tous les jours à 20h00
      - DIUN_PROVIDERS_DOCKER=true
    volumes:
      - /path/to/docker-data/diun/data:/data
      - /ptah/to/docker-data/diun/diun.yml:/diun.yml:ro
      - /var/run/docker.sock:/var/run/docker.sock
    restart: unless-stopped
    networks:
      - pi_frontend

networks:
  pi_frontend:
    external: true
```

Pour créer le conteneur et le lancer

````bash
sudo docker-compose up -d
````



## Le fichier de configuration diun.yml

```yaml
notif:
  mail:
    host: smtp.gmail.com
    port: 465
    ssl: true
    insecureSkipVerify: false
    username: my.mailbox@gmail.com
    password: password# my Google dedicated app password
    from: my.mailbox@gmail.com
    to:
      - my.mailbox@gmail.com
    templateTitle: "Docker OMV {{ .Entry.Image }} released"
    templateBody: |
      Docker tag {{ .Entry.Image }} which you subscribed to through {{ .Entry.Provider }} provider has been released.
```



## Pour créer un mot de passe d'application Google

1. Se connecter à l'adresse suivante : https://myaccount.google.com
2. Sélectionner l'onglet sécurité
3. Activer la validation en 2 étapes (si ce n'est pas déjà fait)
4. Sélectionner mot de passe des applications
