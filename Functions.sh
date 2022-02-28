#!/bin/bash
source yad.sh
function help_txt(){
cat help.txt
}


#####################################################################################


function nombre_taille_fichier(){
x=$( ls -l | find -mtime -1 | wc -l )
x=`expr $x - 1`
echo "NOMBRE FICHIER MODIFIER: $x"
echo "TAILLE FICHIER MODIFIER:"; find -mtime -1 -exec du -b '{}' \; | tail -$x
}


#####################################################################################


function archive(){
find -mtime -1 | tar cvzf archivetar.tar.gz $HOME
}


#####################################################################################


function rename(){
mv $1 $(date +%F-%H:%M).tar.gz
}


#####################################################################################


function nom_version(){
echo "LES AUTEURS:
Yassine Khemiri
Ons Khiari"
echo "VERSION 1.0"
}


#####################################################################################


function sauvegarder(){ 
read -p "ENTRER NOM FICHIER: " fichier
contenue=$( tar -ztvf $1)
touch $fichier
echo "$contenue" > $fichier
}


#####################################################################################

function menu(){
while (( choix !=8 ))
do
echo -e "\n 1 : HELP !
     \n 2 : AFFICHER NOMBRE ET TAILLE DES FICHIER MODIFIER DANS LES DERNIERES 24HEURS
     \n 3 : ARCHIVER LES FICHIERS MODIFIER DANS LES ERNIERES 24HEURS
     \n 4 : RENOMMER L'ARCHIVE AVEC LA DATE ET L'HEURE DE LA MODIFICATION
     \n 5 : AFFICHER LE NOM DES AUTEURS ET LA VERSION DU CODE
     \n 6 : CREER UN FICHIER POUR SAUVEGARDER LES INFORMATIONS SUR LES FICHIERS ARCHIVEES
     \n 7 : AFFICHER UN MENU GRAPHIQUE AVEC PLUSIEURS INTERFACES
     \n 8 : EXIT ! "


read -p "ENTRER VOTRE CHOIX " choix

case $choix in
    1) help_txt
    ;;
    2) nombre_taille_fichier
    ;;
    3) archive
    ;;
    4) read -p "ENTRER NOM DU FICHIER : " nom
     rename $nom
    ;;
    5) nom_version
    ;;
    6) read -p "ENTRER NOM ARCHIVE: " arch
	sauvegarder $arch
    ;;
    7) menuV
    ;;
    8) exit
    ;;
    *) echo "ERREUR"
esac
done
}


#####################################################################################

function menuV()
{
while (( choix != 8 ))
do
echo -e "\n 1 : HELP !
     \n 2 : AFFICHER NOMBRE ET TAILLE DES FICHIER MODIFIER DANS LES DERNIERES 24HEURS
     \n 3 : ARCHIVER LES FICHIERS MODIFIER DANS LES ERNIERES 24HEURS
     \n 4 : RENOMMER L'ARCHIVE AVEC LA DATE ET L'HEURE DE LA MODIFICATION
     \n 5 : AFFICHER LE NOM DES AUTEURS ET LA VERSION DU CODE
     \n 6 : CREER UN FICHIER POUR SAUVEGARDER LES INFORMATIONS SUR LES FICHIERS ARCHIVEES
     \n 7 : AFFICHER UN MENU GRAPHIQUE AVEC PLUSIEURS INTERFACES
     \n 8 : EXIT ! "


read -p "ENTRER VOTRE CHOIX " choix

case $choix in
	1) yad --geometry=700x500+500+200 --text "
•***************L'OBJECTIF:

Ce script permettant de faire l’archive des fichiers de votre répertoire personnel.



***************LES OPTIONS:

• -n : Pour afficher le nombre de fichier et la taille totale occupée des fichiers modifiés dans les dernières 24heures.


• -a : Pour archiver dans une « archive tar » (fichier *.tar.gz) tous les fichiers de votre répertoire personnel (/home/votre-nom) qui ont été modifiés dans les dernières 24 heures.


• -r : pour renommer l’archive avec la date et l’heure de la modification.


• -s FICHIER : pour sauvegarder les informations sur les fichier archivé (nom-type-droit d’accès-date et heure de modification) dans un fichier passé en argument.


• -m : pour afficher un menu textuel (en boucle) qui permet d’accédé à chaque fonction


• -g : une fonction qui permet d’afficher un menu graphique avec plusieurs interface (vous pouvez utiliser YAD)


• -G: Pour afficher un menu textuel et gérer les fonctionnalité de façon graphique(Utilisation de YAD).

• -v: Pour afficher le nom des auteurs et version du code.


• -h: Pour afficher le help détaillé à partir d’un fichier texte


"
	;;
	2) x=$( ls -l | find -mtime -1 | wc -l )
	x=`expr $x - 1`
	k=$(find -mtime -1 -exec du -b '{}' \; | tail -$x)
	yad --geometry=700x500+500+200 --text "NOMBRE FICHIER MODIFIER: $x 
					       TAILLE FICHIER MODIFIER: $k"
	;;
	3) find -mtime -1 | tar cvzf archivetar.tar.gz $HOME
	yad --geometry=700x500+500+200 --text "done !" 
	;;
	4) nom=$( yad --entry --text='ENTRER NOM DU FICHIER' )
	mv $nom $(date +%F-%H:%M).tar.gz
	yad --geometry=700x500+500+200 --text "done !"
	;;
	5) 	yad --geometry=700x500+500+200 --text " LES AUTEURS : 
Yassine Khemiri
Ons Khiari
VERSION 1.0
"
	;;
	6) read -p "ENTRER NOM FICHIER: " fichier
	read -p "ENTRER NOM DE L'ARCHIVE: " archive
contenue=$( tar -ztvf $archive)
touch $fichier
echo "$contenue" > $fichier
	yad --geometry=700x500+500+200 --text "$contenue"
	;;
	7) graphic
	;;
	8) exit
	;;
	*) echo "verifer votre choix"
esac
done
}


#####################################################################################
