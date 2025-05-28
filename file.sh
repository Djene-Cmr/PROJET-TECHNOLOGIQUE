#!/bin/bash

# === Répertoire source ===
DOWNLOADS="$HOME/Téléchargements"

# === Création des sous-dossiers ===
mkdir -p "$DOWNLOADS"/{Images,PDFs,Archives,Documents,Autres}

# === Traitement des fichiers ===
for file in "$DOWNLOADS"/*; do
    # Vérifie que c'est un fichier régulier
    [ -f "$file" ] || continue

    # Récupère l’extension en minuscules
    ext="${file##*.}"
    ext="${ext,,}"  # met en minuscules

    # Ignore les fichiers déjà triés
    case "$file" in
        "$DOWNLOADS"/Images/*|"${DOWNLOADS}"/PDFs/*|"${DOWNLOADS}"/Archives/*|"${DOWNLOADS}"/Documents/*|"${DOWNLOADS}"/Autres/*)
            continue ;;
    esac

    # Redirige selon l'extension
    case "$ext" in
        jpg|jpeg|png|gif|bmp|svg)      dest="Images" ;;
        pdf)                           dest="PDFs" ;;
        zip|rar|tar|gz|7z|bz2)         dest="Archives" ;;
        txt|doc|docx|odt|xls|xlsx|ppt|pptx) dest="Documents" ;;
        *)                             dest="Autres" ;;
    esac

    # Déplace le fichier
    mv "$file" "$DOWNLOADS/$dest/"
    echo "Déplacé : $(basename "$file") → $dest/"
done

echo "✅ Tri terminé dans $DOWNLOADS"
# === Fin du script ===