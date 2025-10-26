#!/bin/bash

output="tableau_fr.tsv"
echo -e "N°\tURL\tNombre_de_mots\tCode_HTTP\tEncodage" > "$output"

if [ $# -lt 1 ]; then
    echo "Usage: $0 <fichier>"
    exit 1
fi
while read -r line;
do
	echo ${line};
done < "$1";

n=0
while read -r url; do
    [[ -z "$url" ]] && continue

    ((n++))

    # Code HTTP
    code_http=$(curl -s -o /dev/null -w "%{http_code}" "$url")

    # Correction si erreur et URL sans http(s)
    if [[ "$code_http" == "000" && "$url" != http* ]]; then
        url="https://$url"
        code_http=$(curl -s -o /dev/null -w "%{http_code}" "$url")
    fi

    # Encodage
    encodage=$(curl -sI "$url" | grep -i "content-type" | grep -oE "charset=[^ ;]*" | cut -d= -f2)
    if [ -z "$encodage" ]; then
        encodage="inconnu"
    fi

    # Nombre de mots
    nb_mots=$(curl -s "$url" | wc -w)

	echo -e "${n}\t${url}\t${nb_mots}\t${code_http}\t${encodage}" >> "$output"
done < "$1"

