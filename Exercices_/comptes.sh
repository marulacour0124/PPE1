!/bin/bash

annees=(2016 2017 2018)

for an in "${annees[@]}"; do
    count=$(grep -h "Location" *.ann | wc -l)
    echo "$an : $count"
done
