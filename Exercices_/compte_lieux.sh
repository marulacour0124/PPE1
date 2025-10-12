#!/bin/bash
# Usage : ./compte_lieux.sh <année ou "*"""> <mois ou "*""> <nombre>

#il doit y avoir obligatoirement 3 arguments, l'année ou *, le mois ou *, le nb de lieux à afficher
[ $# -ne 3 ] && echo "Usage: $0 <année|*> <mois|*> <nombre>" && exit 1
ANNEE=$1
MOIS=$2
N=$3

# Chemin complet vers le dossier contenant les fichiers .ann, à changer
ANN_DIR="/Users/prune/Downloads/projet encadré/Exercice1/ann"

[ ! -d "$ANN_DIR" ] && echo "Dossier $ANN_DIR introuvable" && exit 1

find "$ANN_DIR" -type f -name "*.ann" | while read -r f; do
  base=$(basename "$f")

  # L'année et le mois sont extraits depuis le nom du fichier (ex: 2016-07-*.ann)
  if [[ "$base" =~ ([0-9]{4})[-_]?([0-9]{2})? ]]; then
    an="${BASH_REMATCH[1]}"
    mois="${BASH_REMATCH[2]}"
  else
    an=""; mois=""
  fi

  [[ "$ANNEE" != "*" && "$ANNEE" != "$an" ]] && continue
  [[ "$MOIS" != "*" && "$MOIS" != "$mois" ]] && continue

  grep -E '\bLocation\b' "$f" 2>/dev/null | awk '{for(i=5;i<=NF;i++) printf $i" "; print ""}'
done | sed 's/ *$//' | sort | uniq -c | sort -nr | head -n "$N"
