#!/usr/bin/env bash

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <année> <type>"
  exit 1
fi

ANNEE="$1"
TYPE="$2"

# Chemin absolu vers le dossier contenant les fichiers .ann
ANN_DIR="/Users/prune/Downloads/projet encadré/Exercice1/ann"

# Vérifie que le dossier existe
[ ! -d "$ANN_DIR" ] && echo "Dossier $ANN_DIR introuvable" && exit 1

# Compte toutes les lignes contenant le type dans les fichiers dont le nom contient l'année
count=$(find "$ANN_DIR" -type f -name "*$ANNEE*.ann" -exec grep -h "$TYPE" {} + | wc -l)

# Affiche juste le nombre
echo "$count"
