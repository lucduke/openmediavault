# Installation de Duplicati

## A propos

Duplicati est un logiciel de sauvegarde qui planifie et stocke  une copie complète ou incrémentielle de fichiers à conserver. La copie  de sauvegarde peut être compressée, chiffrée et stockée localement ou en ligne.  

Lien vers l'image : [https://hub.docker.com/r/linuxserver/...](https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqbkhIMnhPQ0l3bndhVDJpbEVvRnRHTTlid1RQZ3xBQ3Jtc0trRnNMcWdQQWFES2dlS09CaVFMYWNDX0JBeHpLbExiZHNINlZZVXBpb09jRVpncDZSU0lpUHZ1ZHlpajZnUDUwbXBOaTBZMlVlZjgtXzFJY3NOR3phanlBUVZpLUhPT2FVdmU3eEtCOXNYMGQwWThyTQ&q=https%3A%2F%2Fhub.docker.com%2Fr%2Flinuxserver%2Fduplicati&v=_c5z0wlQbK8) 

Lien du projet : [https://www.duplicati.com/](https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqblVhSWtGWUtSTHlGR2Z2WWR3VnVMVzdqNU10UXxBQ3Jtc0trVHd5TGFxaXZtRFBZOVNnamFINWRNYW5faFpZTWJNUnMzTHB0Z1dTcGs5aGg2a2YwbmRUU3dVSFR4QWxfYnBUQ0daRThnbWZsUnU4d2o3WlpuWklaTW5pd0h2dWhiVUgxZGJBQlBBSGtTa2JtQm9nUQ&q=https%3A%2F%2Fwww.duplicati.com%2F&v=_c5z0wlQbK8)



## Tutoriel vidéos

[Lien vers la vidéo](https://youtu.be/_c5z0wlQbK8)



## Le fichier de configuration docker-compose

Pour celles et ceux souhaitant créer le conteneur via la saisie d'un stack dans Portainer, voici le détail du fichier de configuration utilisé

```yaml
version: "3.8"

services:

  duplicati:
    container_name: duplicati
    image: ghcr.io/linuxserver/duplicati:latest
    labels:
      - deunhealth.restart.on.unhealthy=true
      - diun.enable=true
      - com.centurylinklabs.watchtower.enable=true
    environment:
      - PUID=0 #id root (pour pouvoir accéder à tous les fichiers)
      - PGID=0 #gid root
      - TZ=Europe/Paris
    volumes:
      - /path/to/docker-data/duplicati/backups:/backups:rw
      - /path/to/docker-data/duplicati/config:/config:rw
      - /path/to/docker-data:/source/docker-data:rw
      - /path/to/documents:/source/documents:rw
      - /path/to/media:/source/media:rw
    ports:
      - 8200:8200/tcp
    restart: unless-stopped
    networks:
      - christophe_frontend

networks:
  christophe_frontend:
    # A ajouter si ce docker network existe deja
    #external: true
```



## On se connecte sur notre conteneur duplicati

http://<host-IP>:8200

