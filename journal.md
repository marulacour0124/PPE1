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


### 26 Octobre 2025 - mini projet 

## Exercice 1 

```bash

```

Utiliser la commande cat dans ce cas rajoute un processus en plus pour exécuter cat:
Tout d'abord, cat qui lit le fichier puis envoie son contenu dans le pipe, puis une boucle while read. Sans cat aucun pipe n'est utilisé et le shell lit le fichier avec la redirection <, la boucle s'exécute dans le shell. C'est donc plus efficace, surtout quand les modifications de variables ne sont pas forcément conservées dans le sous shell lors d'une boucle.

### Pour transformer urls/fr.txt en paramètre du script

On replace la ligne done < "urls/fr.txt" par done <"$1" qui est le premier argument passé au script. 

### Pour vérifier qu'un argument a bien été donné

```bash

```

$# contient le nombre d'arguments passés au script. La commande entière signifie; s'il y a moins d'un argument...
Alors on affiche le message "Usage: $0 <fichier>" pour indiquer comment il faut rentrer l'argument. Le script s'arrête avec exit 1 pour éviter les erreurs.   

### Pour afficher le numéro de ligne avant chaque URL

```bash

```

On initialise un compteur à zéro puis on exécute une boucle qui s'exécute tant qu'il reste des lignes à lire dans le fichier.read -r line lit une ligne du fichier à chaque tour de boucle et stocke cette ligne dans la variable line. ((n++) incrémente le compteur n de 1 à chaque itération. 

```bash

```

- echo affiche du texte à l'écran.
- L'option -e permet d'interpréter les caractères spéciaux comme \t (tabulation).
- ${n} affiche le numéro de ligne actuel.
- ${line} affiche le contenu de la ligne lue (l'URL).
- \t insère une tabulation entre les deux pour bien séparer les colonnes.

La redirection < "$1" indique que le contenu du fichier donné en argument (ici $1) est la source des lignes lues par la boucle.

## Exercice 2 : récupérer les métadonnées de collecte

### Pour obtenir le code http

```bash

```

On ignore le contenu de la page web avec -s -o /dev/null. C'est -w "%{http_code}" qui affiche le code de la réponse http. 

### Pour corriger les erreurs

```bash

```

Si curl retourne 000, cela signifie que la requête n'a pas abouti (souvent parce qu'il manque https://). On corrige alors automatiquement l'URL en ajoutant https:// devant, puis on refait la requête.

### Pour l'encodage

```bash

```

- curl -sI : ne télécharge que les en-têtes HTTP.
- grep -i "content-type" : cherche la ligne contenant le type MIME et l'encodage.
- grep -oE "charset=[^ ;]*" : isole la partie charset=....
- cut -d= -f2 : récupère uniquement la valeur (ex. UTF-8).

Si rien n'est trouvé, on affiche "inconnu". 

### Nombre de mots dans la page

```bash

```

curl -s "$url" télécharge le contenu HTML de la page. wc -w : compte le nombre de mots (séparés par des espaces). Cela donne une approximation de la taille du contenu texte.

### Pour tout afficher avec tabulations

L'option -e permet à echo d'interpréter \t (tabulation).