#!/bin/bash
#chemin absolu à changer

ANN_DIR="/Users/prune/Downloads/projet encadré/Exercice1/ann"

annees=(2016 2017 2018)

for an in "${annees[@]}"; do
    count=$(grep -h "Location" "$ANN_DIR"/"$an"-*.ann 2>/dev/null | wc -l)
    echo "$an : $count"
done



