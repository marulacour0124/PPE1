!/usr/bin/env bash

YEARS=(2016 2017 2018)

for year in "${YEARS[@]}"; do
  if [ -d "$year" ]; then
    search_path="$year"
    include='*.ann'
  else
    search_path='.'
    include="*${year}*.ann"
  fi

 
  count=$(grep -R --include="$include" -h 'Location' "$search_path" 2>/dev/null | wc -l)

  printf "%s : %d\n" "$year" "$count"
done
