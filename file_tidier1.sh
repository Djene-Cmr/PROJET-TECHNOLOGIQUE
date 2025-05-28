#!/bin/bash
# =========================================
# File-Tidier - Tri automatique de fichiers
# Auteur : Votre Nom
# =========================================

# Répertoire cible (par défaut ~/Téléchargements)
TARGET_DIR="$HOME/Téléchargements"
DRY_RUN=false
LOG_FILE=""

# Affiche l'aide
show_help() {
    cat <<EOF
Usage: $0 [répertoire] [options]

Options :
  -t, --test       Mode test (aucun fichier déplacé)
  -h, --help       Affiche cette aide

Exemples :
  $0                     # Trie ~/Téléchargements
  $0 /chemin/vers/mon_dossier
  $0 /chemin -t          # Mode test
EOF
}

# Journalisation
log_action() {
    local message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" >> "$LOG_FILE"
}

# Crée les dossiers nécessaires
create_folders() {
    mkdir -p "$TARGET_DIR"/{Images,PDFs,Archives,Documents,Autres}
}

# Détermine le dossier cible
get_destination_folder() {
    local mime_type="$1"
    case "$mime_type" in
        image/*) echo "Images" ;;
        application/pdf) echo "PDFs" ;;
        application/zip|application/x-7z-compressed|application/x-rar|application/x-tar|application/x-gzip) echo "Archives" ;;
        text/plain|application/msword|application/vnd*) echo "Documents" ;;
        *) echo "Autres" ;;
    esac
}

# Traitement des fichiers
process_files() {
    echo "Traitement des fichiers dans : $TARGET_DIR"
    for file in "$TARGET_DIR"/*; do
        [ -f "$file" ] || continue
        mime_type=$(file --mime-type -b "$file")
        dest_folder=$(get_destination_folder "$mime_type")
        dest_path="$TARGET_DIR/$dest_folder/$(basename "$file")"

        if [ "$DRY_RUN" = true ]; then
            echo "[TEST] $file → $dest_path"
        else
            mv "$file" "$TARGET_DIR/$dest_folder/" 2>/dev/null
            if [ $? -eq 0 ]; then
                log_action "Déplacé: $(basename "$file") → $dest_folder/"
            else
                log_action "Erreur: Impossible de déplacer $(basename "$file")"
            fi
        fi
    done
}

# Analyse des arguments
parse_args() {
    for arg in "$@"; do
        case "$arg" in
            -t|--test) DRY_RUN=true ;;
            -h|--help) show_help; exit 0 ;;
            /*) TARGET_DIR="$arg" ;;
            *) echo "Option inconnue : $arg"; show_help; exit 1 ;;
        esac
    done
}

# MAIN
parse_args "$@"

# Validation dossier
if [ ! -d "$TARGET_DIR" ]; then
    echo "Erreur : le dossier '$TARGET_DIR' n'existe pas."
    exit 1
fi

LOG_FILE="$TARGET_DIR/file_tidier.log"

create_folders
process_files

echo "Tri terminé. Voir le journal : $LOG_FILE"
