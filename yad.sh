#!/bin/bash
function graphic()
{ 
source Functions.sh
exitt=0


while (( $exitt == 0 ))
do
retour=$( yad --title="Sauvegarde" --list --geometry=700x500+500+200 --column="Options" "AFFICHER NOMBRE ET TAILLE DES FICHIER MODIFIER DANS LES DERNIERES 24HEURS" "ARCHIVER LES FICHIERS MODIFIER DANS LES ERNIERES 24HEURS" "RENOMMER L'ARCHIVE AVEC LA DATE ET L'HEURE DE LA MODIFICATION" "AFFICHER LE NOM DES AUTEURS ET LA VERSION DU CODE" "CREER UN FICHIER POUR SAUVEGARDER LES INFORMATIONS SUR LES FICHIERS ARCHIVEES" "HELP" "EXIT" )
echo $retour


	if [[ "$retour" == "AFFICHER NOMBRE ET TAILLE DES FICHIER MODIFIER DANS LES DERNIERES 24HEURS|" ]]; then
		x=$( ls -l | find -mtime -1 | wc -l )
		x=`expr $x - 1`
		taille=$(find -mtime -1 -exec du -b '{}' \; | tail -$x)
		yad --geometry=700x500+500+200 --text "
				NOMBRE FICHIER MODIFIER: $x TAILLE FICHIER MODIFIER: $taille"
	elif [[ "$retour" == "ARCHIVER LES FICHIERS MODIFIER DANS LES ERNIERES 24HEURS|" ]]; then
		find -mtime -1 | tar cvzf archivetar.tar.gz $HOME
		yad --geometry=700x500+500+200 --text "done !"
	elif [[ "$retour" == "RENOMMER L'ARCHIVE AVEC LA DATE ET L'HEURE DE LA MODIFICATION|" ]]; then
		nom=$( yad --entry --text='ENTRER NOM DU FICHIER' )
		mv $nom $(date +%F-%H:%M).tar.gz
		yad --geometry=700x500+500+200 --text "done !"
	elif [[ "$retour" == "CREER UN FICHIER POUR SAUVEGARDER LES INFORMATIONS SUR LES FICHIERS ARCHIVEES|" ]]; then
		fichier=$( yad --entry --text='ENTRER NOM DU FICHIER' )
		archive=$( yad --entry --text='ENTRER NOM DE L ARCHIVE' )
		contenue=$( tar -ztvf $archive)
		touch $fichier
		echo "$contenue" > $fichier
	yad --geometry=700x500+500+200 --text "$contenue"
	elif [[ "$retour" == "AFFICHER LE NOM DES AUTEURS ET LA VERSION DU CODE|" ]]; then
		yad --geometry=700x500+500+200 --text "LES AUTEURS:
	Yassine Khemiri 
	Ons Khiari
	VERSION 1.0"
	elif [[ "$retour" == "HELP|" ]]; then
		yad --geometry=700x500+500+200 --text "
***************L'OBJECTIF:

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


• -h: Pour afficher le help détaillé à partir d’un fichier texte"
else exit
fi
done
}
