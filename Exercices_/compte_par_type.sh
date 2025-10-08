!/usr/bin/env bash

if [ "$#" -ne 2 ]; then
  echo "Usage : $0 <année> <type>"
  exit 1
fi

annee="$1"
type="$2"

if [[ ! "$annee" =~ ^(2016|2017|2018)$ ]]; then
  echo "Erreur : année invalide ($annee)"
  exit 1
fi

if [ -d "$annee" ]; then
  search_path="$annee"
  include="*.ann"
else
  search_path="."
  include="*${annee}*.ann"
fi

count=$(grep -R --include="$include" -h "$type" "$search_path" 2>/dev/null | wc -l)
echo "$count"
