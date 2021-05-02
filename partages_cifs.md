# Gestion des partages CIFS/SMB et montage des répertoires partagés depuis Windows / Linux



## Tutoriel vidéo

[lien vers la vidéo Youtube](https://youtu.be/e1M3HaaJLeY)



## Paramétrage OMV

cf. le tutoriel vidéo



## Création d'un répertoire réseau sous Windows

Cf. le tutoriel vidéo



## Montage d'un partage CIFS/SMB sous Linux

### Création d'un fichier avec les paramètres de connexion

````bash
# Création du fichier d'authentification cifs (dans le home de votre utilisateur pour mon exemple)
echo "username=votre_utilisateur" > /home/pi/.smbcred
echo "password=votre_mot_de passe" >> /home/pi/.smbcred
echo "domain=WORKGROUP" >> /home/pi/.smbcred
````

### Création du point de montage

````bash
# Création du point de montage
sudo mkdir -p /mnt/dossier/
````

### Paramétrage du fstab pour un montage automatique du partage

Dans cet exemple, le partage cifs sera monter dans le dossier /mnt/dossier

````bash
# Edition du fstab avec nano
sudo nano /etc/fstab

# Ajout de la ligne suivante
//serveur_distant/test /mnt/dossier cifs cifsacl,auto,exec,comment=systemd.automount,uid=1000,gid=100,credentials=/home/pi/.smbcred 0 0

# Montage du partage
sudo mount -a
````



## Liens

Explication pour les options du montage CIFS dans FSTAB : https://linux.die.net/man/8/mount.cifs

