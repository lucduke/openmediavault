# Installation de bitwarden

## A propos

Biwarden est une application gratuite et open source pour conserver, dans un coffre numérique sécurisé, vos données sensibles tels que vos mots de passe.

L’avantage est que vous n’avez qu’un seul mot de passe à retenir (celui pour accéder au coffre numérique sécurisé).

Par ailleurs, bitwarden étant multi-plateforme (windows, macOS, linux, iOS, Android), vous pouvez facilement accéder à vos données depuis vos différents terminaux.

Lien vers le projet : [https://bitwarden.com](https://bitwarden.com/)

Lien vers l’image : https://hub.docker.com/r/bitwardenrs/server



## Tutoriel vidéos

[Lien vers la vidéo](https://youtu.be/YEXCpgbA86M)



## Le fichier de configuration docker-compose

Pour celles et ceux souhaitant créer le conteneur via la saisie d'un stack dans Portainer, voici le détail du fichier de configuration utilisé

```yaml
version: "3.8"

services:

  bitwarden:
    container_name: bitwarden
    image: bitwardenrs/server:latest
    labels:
      - deunhealth.restart.on.unhealthy=true
      - diun.enable=true
      - com.centurylinklabs.watchtower.enable=true
    environment:
      - SIGNUPS_ALLOWED=true
    volumes:
      - /path/to/docker-data/bitwarden/data:/data/
    ports:
      - 91:80/tcp #WebUI port
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



## On se connecte sur notre conteneur bitwarden

http://<host-IP>:91

