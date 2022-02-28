#!/bin/bash

source Functions.sh
source yad.sh

if [ $# -gt 0 ]; then
while getopts "hnear:mvgGs:" choix
do
    case $choix in
    h) help_txt
    ;;
    n) nombre_taille_fichier
    ;;
    a) archive
    ;;
    r) rename $2
    ;;
    m) menu
    ;;
    v) nom_version
    ;;
    s) sauvegarder $2
    ;;
    g) graphic
    ;;
    G) menuV
    ;;
    *) echo " ERREUR ! CHECK HELP [-h] !"
    exit
    ;;
   esac

done
else echo "ENTRER UN SEUL ARGUMENT ! "
fi
