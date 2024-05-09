#!/bin/bash

# Vérifie s'il y a au moins deux fichiers en argument
if [ "$#" -lt 2 ]; then
    echo "Erreur : Vous devez spécifier au moins deux fichiers."
    exit 1
fi

# Fichier de sortie
output_file="output.txt"

# Concaténation de tous les fichiers
cat "$@" > "$output_file"

# Affichage du contenu concaténé dans l'ordre inverse
echo "Contenu des fichiers concaténés dans l'ordre inverse :"
tac "$output_file"

# Suppression du fichier de sortie
rm "$output_file"
