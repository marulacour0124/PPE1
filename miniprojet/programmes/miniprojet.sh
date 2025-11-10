#!/bin/bash

# changez le dossier de sortie 
output_dir="/Users/prune/Downloads/projet encadré/PPE1-2526/PPE1/miniprojet/tableaux"
output="$output_dir/tableau_fr.html"

# explications:
echo "------------------------------------------------------------"
echo "Le fichier HTML sera enregistré ici :"
echo "   $output"
echo ""
echo "Pour changer cet emplacement :"
echo "   Ouvrez ce script ('tableau_html.sh') dans un éditeur de texte"
echo "   et modifiez la variable :"
echo "       output_dir=\"/chemin/vers/votre/dossier\""
echo "------------------------------------------------------------"
echo ""

mkdir -p "$output_dir"

# fichier HTML
cat <<EOF > "$output"
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Résultats de l'analyse d'URLs</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f8f9fa; }
        h1 { color: #333; }
        table { border-collapse: collapse; width: 100%; background: white; }
        th, td { border: 1px solid #999; padding: 8px 12px; text-align: left; }
        th { background-color: #007BFF; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        a { color: #007BFF; text-decoration: none; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
<h1>Analyse des URLs</h1>
<table>
    <tr>
        <th>N°</th>
        <th>URL</th>
        <th>Nombre de mots</th>
        <th>Code HTTP</th>
        <th>Encodage</th>
    </tr>
EOF


if [ $# -lt 1 ]; then
    echo "Usage: $0 <fichier>"
    exit 1
fi

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

    # Ajout de la ligne au tableau HTML
    echo "    <tr><td>$n</td><td><a href=\"$url\" target=\"_blank\">$url</a></td><td>$nb_mots</td><td>$code_http</td><td>$encodage</td></tr>" >> "$output"

done < "$1"


cat <<EOF >> "$output"
</table>
</body>
</html>
EOF

echo " Fichier HTML généré dans $output"
