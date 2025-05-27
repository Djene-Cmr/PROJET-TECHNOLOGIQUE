#!/bin/bash 
# ============================
# File-Tidier - Tri automatique de fichiers
# ============================

# Répertoire à trier (par défaut : ~/Téléchargements)
TARGET_DIR="${1:-$HOME/Téléchargements}"

# Fichier de log
LOG_FILE="$TARGET_DIR/file_tidier.log"

# Mode test (dry-run) : affiche les actions sans les exécuter
DRY_RUN=false

# Affiche l'aide
show_help() {
    echo "Usage: $0 [répertoire] [options]"
    echo ""
    echo "Options :"
    echo "  -t, --test       Mode test (aucun fichier déplacé)"
    echo "  -h, --help       Affiche cette aide"
    echo ""
    echo "Exemple : $0 ~/Téléchargements -t"
}

# Journalisation
log_action() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Crée les dossiers de destination
create_folders() {
    mkdir -p "$TARGET_DIR"/{Images,PDFs,Archives,Documents,Autres}
}

# Détermine le dossier de destination selon le type MIME
get_destination_folder() {
    local mime_type="$1"
    case "$mime_type" in
        image/*) echo "Images" ;;
        application/pdf) echo "PDFs" ;;
        application/zip|application/x-tar|application/x-gzip|application/x-7z-compressed) echo "Archives" ;;
        text/plain|application/msword|application/vnd*) echo "Documents" ;;
        *) echo "Autres" ;;
    esac
    
}

# Traitement des fichiers
process_files() {
    for file in "$TARGET_DIR"/*; do
        [ -f "$file" ] || continue
        mime_type=$(file --mime-type -b "$file")
        dest_folder=$(get_destination_folder "$mime_type")
        dest_path="$TARGET_DIR/$dest_folder/$(basename "$file")"

        if [ "$DRY_RUN" = true ]; then
            echo "[TEST] $file → $dest_path"
        else
            mv "$file" "$TARGET_DIR/$dest_folder/"
            log_action "Déplacé: $(basename "$file") → $dest_folder/"
        fi
    done
}

# ============================
# Programme principal
# ============================

# Analyse des options
while [[ "$2" != "" ]]; do
    case $2 in
        -t|--test) DRY_RUN=true ;;
        -h|--help) show_help; exit 0 ;;
        *) echo "Option inconnue : $2"; show_help; exit 1 ;;
    esac
    shift
done

# Exécution
create_folders
process_files

echo "Tri terminé. Voir le journal : $LOG_FILE"
