# **Personnalisation de Nextcloud**



## Tutoriel vidéo

[Lien vers la vidéo](https://youtu.be/FemlCMaheEc)



## **Ajout d'applications**

Cf. le tutoriel vidéo

### Community Document Server + OnlyOffice

Prérequis : disposer d'un espace libre significatif et modifier le timeout dans le fichier php suivant

```bash
# On vient modifier le timeout à 300
sudo nano ~/docker-data/nextcloud-app/var/www/html/lib/private/Http/Client/Client.php
```

### External storage support

Prérequis : disposer de smbclient dans le conteneur

```bash
# Se connecter dans le conteneur et lancer bash
sudo docker exec -it nextcloud-app bash

# Une fois dans le conteneur
apt update
apt install smbclient
exit

# On relance le conteneur
sudo docker restart nextcloud-app
```

### Camera Raw Preview

### Ransomware Protection

### Plain Text Editor + Markdow Editor



## **Désactivation d'applications**

Cf. le tutoriel vidéo



## Ajout d'utilisateurs

Cf. le tutoriel vidéo



## Astuce

On peut automatiser l'installation périodique de smbclient dans le conteneur nextcloud via Anacron

```shell
sudo nano /etc/anacrontab
```

Puis saisir le texte suivant

```tex
1	10	container.apt.upd	docker exec -it nextcloud-app apt update
1	12	container.apt.inst.smblient	docker exec -it nextcloud-app apt install smbclient -y
1	14	container.restart	docker restart nextcloud-app
```

