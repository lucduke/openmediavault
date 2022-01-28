# Installation de podgrab

## A propos

Podgrab est une application auto-hébergée qui permet de suivre, rechercher des podcast et télécharger les épisodes dans un répertoire de votre choix au format MP3



Lien vers le projet : https://github.com/akhilrex/podgrab

Pour récupérer des podcasts : https://podcasts-francais.fr



## Tutoriel vidéos

[Lien vers la vidéo](https://youtu.be/_bIoaMMGURQ)



## Le fichier de configuration docker-compose

Pour celles et ceux souhaitant créer le conteneur via la saisie d'un stack dans Portainer, voici le détail du fichier de configuration utilisé

```yaml
version: "3.8"

networks:
  frontend:
    # A ajouter si ce docker network existe deja dans un autre fichier docker-compose
    # external: true

services:

  podgrab:
    container_name: podgrab
    environment:
      - CHECK_FREQUENCY=240 # Fréquence de rafraichissement en min
      - PASSWORD=password   # Optionel, le username = podgrab
    image: akhilrex/podgrab:latest
    labels:
      - deunhealth.restart.on.unhealthy=true
      - diun.enable=true
    ports:
      - 7080:8080 # Modifier à 7080 car mon port 8080 est déjà utilisé 
    restart: unless-stopped
    volumes:
      - /path/to/config:/config
      - /path/to/data:/assets
    networks:
      - frontend
```

Pour créer le conteneur et le lancer

````bash
sudo docker-compose up -d
````



## On se connecte sur notre conteneur podgrab

http://<host-IP>:7080

