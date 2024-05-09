#!/bin/bash

# Fonction pour rendre exécutable les scripts shell commençant par "sh"
rendre_executables() {
    for fichier in "$1"/*; do
        if [ -f "$fichier" ] && [[ "$(basename "$fichier")" == sh* ]]; then
            chmod +x "$fichier"
        fi
    done
}

# Fonction pour copier les fichiers .c et .p dans $HOME/sauve
copier_fichiers() {
    for fichier in "$1"/*; do
        if [ -f "$fichier" ] && [[ "$(basename "$fichier")" == *.c || "$(basename "$fichier")" == *.p ]]; then
            cp "$fichier" "$HOME/sauve/"
        fi
    done
}

# Fonction pour déplacer les rapports antérieurs à l'année 2000 dans $HOME/archives
deplacer_rapports() {
    for fichier in "$1"/*; do
        if [ -f "$fichier" ]; then
            nom=$(basename "$fichier")
            extension="${nom##*.}"  # Extraire l'extension du fichier
            if [ "$extension" == "$nom" ]; then
                annee=${nom: -4}  # S'il n'y a pas d'extension, extraire les 4 derniers caractères
            else
                annee=${nom: -8:4}  # S'il y a une extension, extraire les 4 caractères avant l'extension
            fi
            if [[ "$annee" =~ ^[0-9]+$ ]] && [ "$annee" -lt 2000 ]; then
                mv "$fichier" "$HOME/archives/$nom.old"
            fi
        fi
    done
}



# Vérification des arguments
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <répertoire1> [<répertoire2> ...]"
    exit 1
fi

# Boucle sur les répertoires passés en paramètres
for repertoire in "$@"; do
    if [ -d "$repertoire" ]; then
        rendre_executables "$repertoire"
        copier_fichiers "$repertoire"
        deplacer_rapports "$repertoire"
    else
        echo "$repertoire n'est pas un répertoire valide."
    fi
done
