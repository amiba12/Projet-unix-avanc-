#!/bin/bash

# Fonction pour compter les fichiers dans un répertoire (récursivement)
count_files() {
    local count=0
    local file=""
    for file in "$1"/*; do
        if [ -f "$file" ]; then
            ((count++))
        fi
    done
    echo $count
}

# Fonction pour compter les sous-répertoires dans un répertoire (récursivement)
count_subdirs() {
    local count=0
    local dir=""
    for dir in "$1"/*; do
        if [ -d "$dir" ]; then
            ((count++))
        fi
    done
    echo $count
}

# Fonction pour compter le nombre total de fichiers dans un répertoire (récursivement)
total_file_count() {
    local count=0
    local file=""
    for file in "$1"/*; do
        if [ -f "$file" ]; then
            ((count++))
        elif [ -d "$file" ]; then
            ((count+=$(total_file_count "$file")))
        fi
    done
    echo $count
}

# Fonction pour compter le nombre total de sous-répertoires dans un répertoire (récursivement)
total_subdir_count() {
    local count=0
    local dir=""
    for dir in "$1"/*; do
        if [ -d "$dir" ]; then
            ((count++))
            ((count+=$(total_subdir_count "$dir")))
        fi
    done
    echo $count
}

# Vérifie si au moins un argument est passé
if [ $# -eq 0 ]; then
    echo "Usage: $0 <répertoire1> [<répertoire2> ...]"
    exit 1
fi

# Boucle à travers chaque répertoire passé en paramètre
for directory in "$@"; do
    # Vérifie si le répertoire existe
    if [ ! -d "$directory" ]; then
        echo "Erreur: Le répertoire '$directory' n'existe pas."
        continue
    fi

    echo "Analyse du répertoire : $directory"

    # Compte le nombre de fichiers (simples)
    file_count=$(count_files "$directory")
    echo "Nombre de fichiers simples : $file_count"

    # Compte le nombre de sous-répertoires
    subdir_count=$(count_subdirs "$directory")
    echo "Nombre de sous-répertoires : $subdir_count"

    # Compte le nombre total de fichiers (y compris ceux des sous-répertoires)
    total_file=$(total_file_count "$directory")
    echo "Nombre total de fichiers (y compris ceux des sous-répertoires) : $total_file"

    # Compte le nombre total de sous-répertoires (y compris ceux des sous-répertoires)
    total_subdir=$(total_subdir_count "$directory")
    echo "Nombre total de sous-répertoires (y compris ceux des sous-répertoires) : $total_subdir"

    echo ""
done
