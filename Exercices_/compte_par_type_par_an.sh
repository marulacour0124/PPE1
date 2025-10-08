!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
  echo "Usage : $0 <type>"
  echo "Exemple : $0 Location"
  exit 1
fi

type="$1"

for year in 2016 2017 2018; do
  count=$(./Exercices/compte_par_type.sh "$year" "$type" 2>/dev/null)

  if [ $? -ne 0 ]; then
    echo "$year : erreur"
  else
    echo "$year : $count"
  fi
done
