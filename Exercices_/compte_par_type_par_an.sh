#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
  echo "Usage : $0 <type>"
  echo "Exemple : $0 Location"
  exit 1
fi

TYPE="$1"

# Chemin absolu vers le script compte_par_type.sh, à changer
SCRIPT="/Users/prune/Downloads/projet encadré/PPE1-2526/PPE1/Exercices_/compte_par_type.sh"

for YEAR in 2016 2017 2018; do
  count=$("$SCRIPT" "$YEAR" "$TYPE" 2>/dev/null)
  echo "$YEAR : $count"
done
