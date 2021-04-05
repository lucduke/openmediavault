#!/bin/bash

# The Duke Of Puteaux
# Rejoins moi sur Youtube: https://www.youtube.com/channel/UCsJ-FHnCEvtV4m3-nTdR5QQ

# USAGE
# wget -q -O - https://raw.githubusercontent.com/lucduke/openmediavault/main/qemu-agent.sh | bash

# SOURCES
 

# VARIABLES


echo "----------------------------------------------------------------"
echo "Debut du script"
echo "----------------------------------------------------------------"

#1 MAJ liste des paquets 
echo "- MAJ liste des paquets"
apt update

#2 Installation qemu-agent
echo "- Installation qemu-agent"
apt install -y qemu-guest-agent

#3 MAJ autres paquets
echo "- MAJ autres paquets"
apt full-upgrade -y

#4 Redemarrage OMV
echo "- Redemarrage OMV"
reboot

echo "----------------------------------------------------------------"
echo "Fin du script"
echo "----------------------------------------------------------------"
