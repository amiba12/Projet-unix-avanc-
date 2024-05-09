#!/bin/bash

# Fonction pour compter les nombres pairs
compter_pairs() {
    local count=0
    for num in "$@"; do
        if (( num % 2 == 0 )); then
            (( count++ ))
        fi
    done
    echo "--------------Nombre de nombres pairs: $count---------------"
}

# Fonction pour compter les nombres impairs
compter_impairs() {
    local count=0
    for num in "$@"; do
        if (( num % 2 != 0 )); then
            (( count++ ))
        fi
    done
    echo "--------------Nombre de nombres impairs: $count--------------"
}

# Fonction pour compter les nombres négatifs
compter_negatifs() {
    local count=0
    for num in "$@"; do
        if (( num < 0 )); then
            (( count++ ))
        fi
    done
    echo "-------------Nombre de nombres négatifs: $count--------------"
}

# Fonction pour compter les nombres nuls
compter_nuls() {
    local count=0
    for num in "$@"; do
        if (( num == 0 )); then
            (( count++ ))
        fi
    done
    echo "-------------Nombre de nombres nuls: $count------------------"
}

# Fonction pour compter les nombres positifs
compter_positifs() {
    local count=0
    for num in "$@"; do
        if (( num > 0 )); then
            (( count++ ))
        fi
    done
    echo "-------------Nombre de nombres positifs: $count --------------"
}

# Lecture des nombres depuis l'entrée standard
read -p "Entrez une série de nombres (séparés par des espaces): " -a nombres

# Vérification si l'entrée contient uniquement des nombres
for num in "${nombres[@]}"; do
    if ! [[ $num =~ ^-?[0-9]+$ ]]; then
        echo "Erreur: '$num' n'est pas un nombre valide."
        exit 1
    fi
done

# Appel des fonctions pour compter les différents types de nombres
compter_pairs "${nombres[@]}"
compter_impairs "${nombres[@]}"
compter_negatifs "${nombres[@]}"
compter_nuls "${nombres[@]}"
compter_positifs "${nombres[@]}"
