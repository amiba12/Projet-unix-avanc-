#!/bin/bash

# Fonction pour compter le nombre de lignes contenant la chaîne dans le fichier
compter_lignes() {
    local chaine="$1"
    local fichier="$2"
    local nb_lignes=0
    while IFS= read -r ligne; do
        if [[ "$ligne" == *"$chaine"* ]]; then
            ((nb_lignes++))
        fi
    done < "$fichier"
    echo "$nb_lignes"
}

# Fonction pour afficher les lignes contenant la chaîne avec leurs numéros dans le fichier
afficher_lignes() {
    local chaine="$1"
    local fichier="$2"
    local num_ligne=0
    while IFS= read -r ligne; do
        ((num_ligne++))
        if [[ "$ligne" == *"$chaine"* ]]; then
            echo "---Ligne $num_ligne ---: $ligne"
        fi
    done < "$fichier"
}

# Vérification du nombre d'arguments
if [ "$#" -eq 0 ] || [ "$(( $# % 2 ))" -ne 0 ]; then
    echo "Usage: $0 <chaîne1> <fichier1> [<chaîne2> <fichier2> ...]"
    exit 1
fi

# Boucle sur les couples de chaînes et de fichiers
for (( i = 1; i <= $#; i += 2 )); do
    chaine="${@:i:1}"
    fichier="${@:i+1:1}"
    echo "-----Nom du fichier----- : $fichier"
    nb_lignes=$(compter_lignes "$chaine" "$fichier")
    echo "-----Nombre de lignes contenant----- '$chaine': $nb_lignes"
    afficher_lignes "$chaine" "$fichier"
    echo  # Ligne vide pour la lisibilité
done
