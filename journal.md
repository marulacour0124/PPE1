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

### 12 novembre 2025 --- Syntaxe Bulma 

## Principe général de Bulma

Bulma est un framework CSS moderne basé sur **Flexbox**, conçu pour
offrir une mise en page simple, responsive et élégante sans nécessité de
JavaScript. Il se compose uniquement de classes CSS réutilisables que
l'on ajoute directement dans le HTML.\
Nous l'avons utilisé pour formater notre site GitHub Pages afin de
bénéficier rapidement d'un style propre, cohérent et responsive.

Bulma repose sur deux idées principales :

1.  **Aucune classe personnalisée obligatoire** : tout passe par les
    classes Bulma.
2.  **Structure basée sur des composants** comme `hero`, `section`,
    `navbar`, `card`, etc.

Pour utiliser Bulma, on importe simplement la feuille de style :

``` html
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.0/css/bulma.min.css">
```

------------------------------------------------------------------------
## Les éléments de mise en page utilisés

### 1. La classe `container`

``` html
<div class="container">
    ...
</div>
```

Elle sert à centrer et limiter la largeur du contenu, c'est pratique pour structurer une page GitHub Pages.

------------------------------------------------------------------------

### 2. Les sections : `section` et `hero`

#### `section`

``` html
<section class="section">
    <div class="container">
        ...
    </div>
</section>
```

Utilisée pour découper la page en blocs distincts (introduction,contenu, conclusion...).

#### `hero`

``` html
<section class="hero is-primary">
    <div class="hero-body">
        <p class="title">Mon site GitHub Pages</p>
    </div>
</section>
```

-   `hero` : grand bandeau horizontal
-   `is-primary` : couleur prédéfinie (thème principal de Bulma)
-   `hero-body` : zone de texte centrale

------------------------------------------------------------------------

## La syntaxe des classes utilitaires

Bulma propose des centaines de classes dites **"utilitaires"** permettant de modifier rapidement l'apparence :

### 1. Couleurs

``` html
<p class="has-text-primary">Texte bleu primaire</p>
<p class="has-background-warning">Fond jaune</p>
```

Les couleurs standard sont : `primary`, `link`, `info`, `success`,
`warning`, `danger`.

------------------------------------------------------------------------

### 2. Tailles de texte

``` html
<p class="is-size-1">Titre 1</p>
<p class="is-size-4">Texte moyen</p>
```

Les tailles vont de `is-size-1` (très grand) à `is-size-7` (petit).

------------------------------------------------------------------------

### 3. Marges et espacements

``` html
<div class="mt-5 mb-3 p-4">
```

-   `m` = margin\
-   `p` = padding\
-   `t`, `b`, `l`, `r` = top, bottom, left, right\
-   les valeurs vont de 0 à 6 (`mt-6` = grande marge haute)

------------------------------------------------------------------------

## Les composants utilisés

### 1. `card`

``` html
<div class="card">
    <div class="card-content">
        <p class="title">Titre de carte</p>
        <p class="subtitle">Sous-titre</p>
    </div>
</div>
```

Permet d'encadrer du contenu dans une boîte propre.

------------------------------------------------------------------------

### 2. `navbar`

``` html
<nav class="navbar is-light">
    <div class="navbar-brand">
        <a class="navbar-item">Accueil</a>
    </div>
</nav>
```

Barre de navigation gérée par Bulma via Flexbox.

------------------------------------------------------------------------

## Mise en colonnes (grid system)

Bulma utilise des flexbox pour organiser le contenu en colonnes :

``` html
<div class="columns">
    <div class="column is-half">Colonne 1</div>
    <div class="column is-half">Colonne 2</div>
</div>
```

-   `columns` = conteneur
-   `column` = colonne flexible
-   `is-half`, `is-one-third`, `is-3` = largeur

C'est ce qui nous a permis d'organiser proprement sections, images, texte, etc.

------------------------------------------------------------------------

## Conclusion

Bulma permet de styliser rapidement une page GitHub Pages grâce à
son système de classes prêt à l'emploi, sa mise en page basée sur
Flexbox, ses composants simples (`hero`, `card`, `navbar`, etc.), et
ses classes utilitaires (couleurs, tailles, marges).

Il n'y a rien à configurer puisqu'il suffit d'ajouter des classes dans le
HTML.




### 19 novembre 2025 --- Notes sur les expressions régulières Unicode, sed et Git

## Expressions régulières --- Propriétés Unicode

Les caractères Unicode possèdent de nombreuses propriétés indiquant la
catégorie à laquelle ils appartiennent : lettre, nombre, symbole, etc.

-   `\p{L}+` : recherche tous les caractères ayant la propriété Unicode
    **Letter**.\
-   L'utilisation de `\p{...}` nécessite l'indicateur `u` dans
    l'expression régulière.\
-   Propriétés utiles :
    -   `Letter` : indique que le caractère appartient à un alphabet.
    -   `Number` : indique un chiffre (arabe, chinois, etc.).

### Sous-catégories de la propriété `L` (Letter)

-   `Ll` : lettres minuscules\
-   `Lm` : lettres modificateurs\
-   `Lt` : lettres "titre"\
-   `Lu` : lettres majuscules\
-   `Lo` : autres lettres

### Exemple classique sans propriété Unicode

``` regex
[a-zA-Zèéàâêëîïôöùûüÿç]*
```

------------------------------------------------------------------------

## Commandes sed

-   Remplacement de texte avec sed :

``` bash
sed 's/regex1/remplacement/'
```

------------------------------------------------------------------------

## Git --- Gestion des stashes
Cela va nous être utile lors de la gestion de notre git partagé pour le projet de groupe. 
De nombreux conflits peuvent apparaître. 

### Liste des stashes

``` bash
git stash list
```

Affiche l'ensemble des stashes existants (numérotés à partir de 0).

### Mettre de côté les modifications

``` bash
git stash push
```

Enregistre les modifications en cours « sous le tapis ».

### Voir le contenu d'un stash

``` bash
git stash show
```

Affiche les changements inclus dans le stash qui serait réappliqué.

### Appliquer un stash et le supprimer

``` bash
git stash pop
```

-   Réapplique le dernier stash (`stash@{0}`)
-   Le **supprime** de la pile

### Appliquer un stash sans le supprimer

``` bash
git stash apply
```

Réapplique le stash mais le conserve dans la liste.

### Supprimer un stash sans l'appliquer

``` bash
git stash drop
```

Supprime un stash spécifique de la pile.
