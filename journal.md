# Journal de bord du projet encadré

### 5 octobre 2025 — Travail sur Git
Aujourd’hui, j’ai appris à synchroniser les dépôts Git.
- J’ai créé mon dépôt sur GitHub.
- J'ai créé ce journal de bord. 
- Pour ajouter et valider les changements: git add nomdefichier puis git commit -m 

### 12 octobre 2025 - Explication de script Bash qui vérifie les URL

## Shebang

```bash
#!/usr/bin/bash
```

Le shebang indique que script doit être exécuté avec l’interpréteur bash. Cela permet de lancer le script directement depuis le terminal.

## Vérification des arguments

```bash
if [ $# -ne 1 ]; then
    echo "ce programme demande un argument"
    exit
fi
```

Vérifie le nombre d’arguments passés au script, si on a pas exactement un argument le script prévient l'utilisateur en affichant le message d'erreur puis on quitte le script.

## Initialisation des variables

```bash
FICHIER_URLS=$1
OK=0
NOK=0
```

On récupère le premier argument passé au script et on le stocke dans la variable FICHIER_URLS. Deux compteurs sont initialisés pour les URL valides et non valides. L'espace dans le script semble incorrect.

## Boucle de lecture du fichier

```bash
while read -r LINE; do
    echo "la ligne: $LINE"
```

On entre dans une boucle qui, sur chaque ligne du fichier : affiche le contenu de la ligne actuelle, pour que l’utilisateur voie ce qui est analysé.

## Vérification du format de l’URL

```bash
if [[ $LINE =~ ^https?:// ]]; then
    echo "ressemble à une URL valide"
    OK=$(expr $OK + 1)
else
    echo "ne ressemble pas à une URL valide"
    NOK=$(expr $NOK + 1)
fi
```

On teste si la ligne commence par http:// ou https://, ce qui indiquerait que c’est une URL valide. Si la ligne ressemble à une URL, on affiche un message et on incrémente le compteur OK. Sinon, on affiche que la ligne est douteuse et on incrémente NOK.

## Fin de la boucle et résumé

```bash
done < $FICHIER_URLS
echo "$OK URLs et $NOK lignes douteuses"
```

Termine la boucle while en lisant le fichier fourni en argument. Affichage d'un message à la fin disant combien d'URL sont valides et combien de lignes invalides ont été trouvées.
