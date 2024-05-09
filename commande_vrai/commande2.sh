#!/bin/bash

# Définition des tableaux pour les jours de la semaine et les mois
jours=("Dimanche" "Lundi" "Mardi" "Mercredi" "Jeudi" "Vendredi" "Samedi")
mois=("janvier" "février" "mars" "avril" "mai" "juin" "juillet" "août" "septembre" "octobre" "novembre" "décembre")

# Vérification si une date est fournie
if [ $# -eq 0 ]; then
    echo "Usage: $0 <jour> <mois> <année>"
    exit 1
fi

# Extraction des éléments de la date fournie
jour=$1
mois=$2
annee=$3

# Vérification de la validité du mois
if (( mois < 1 || mois > 12 )); then
    echo "Mois invalide. Veuillez entrer un mois entre 1 et 12."
    exit 1
fi

# Vérification de la validité du jour en fonction du mois
jours_du_mois=(31 29 31 30 31 30 31 31 30 31 30 31)
if (( jour < 1 || jour > ${jours_du_mois[$(($mois - 1))]} )); then
    echo "Jour invalide pour le mois de ${mois[$(($mois - 1))]} $annee."
    exit 1
fi

## Tableau pour convertir le mois de son format numérique à son équivalent en lettres
mois_en_lettres=("janvier" "février" "mars" "avril" "mai" "juin" "juillet" "août" "septembre" "octobre" "novembre" "décembre")

# Utilisation de la commande 'date' pour obtenir le jour de la semaine
jour_de_la_semaine=$(date -d "$3-$2-$1" +%A)

# Conversion du mois de son format numérique à son équivalent en lettres
mois_en_lettres=${mois_en_lettres[$(($2 - 1))]}

# Affichage de la date en toutes lettres
echo " la date est le:------------- $jour_de_la_semaine $1 $mois_en_lettres $3 -----------"
