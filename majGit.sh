#!/bin/bash
# The Duke Of Puteaux
# Rejoins moi sur Youtube: https://www.youtube.com/channel/UCsJ-FHnCEvtV4m3-nTdR5QQ

# USAGE

# SOURCES

# VARIABLES

echo "----------------------------------------------------------------"
echo "Debut du script"
echo "----------------------------------------------------------------"

# MAJ  Github
git pull
echo "MAJ Repo OpenMediaVault"
git add .
git commit -m "Update"
git push origin main

echo "----------------------------------------------------------------"
echo "Fin du script"
echo "----------------------------------------------------------------"