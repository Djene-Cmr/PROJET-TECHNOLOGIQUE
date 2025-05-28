#!/bin/bash
# =========================================
# File-Tidier - Tri automatique de fichiers
# Auteur : Votre Nom
# =========================================

# Répertoire cible par défaut : ~/Téléchargements
TARGET_DIR="$HOME/Téléchargements"
DRY_RUN=false
LOG_FILE=""

# === Fonction d'affichage de l'aide utilisateur ===
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

# === Fonction de journalisation dans un fichier log ===
log_action() {
    local message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" >> "$LOG_FILE"
}

# === Création des dossiers de destination ===
create_folders() {
    mkdir -p "$TARGET_DIR"/{Images,PDFs,Archives,Documents,Autres}
}

# === Détermination du dossier selon le type MIME ===
get_destination_folder() {
    local mime_type="$1"
    case "$mime_type" in
        image/*) echo "Images" ;;
        application/pdf) echo "PDFs" ;;
        application/zip|application/x-7z-compressed|application/x-rar|application/x-tar|application/x-gzip) echo "Archives" ;;
        text/plain|application/msword|application/vnd.openxmlformats-officedocument.*) echo "Documents" ;;
        *) echo "Autres" ;;
    esac
}

# === Traitement des fichiers du répertoire ===
process_files() {
    
    echo " Traitement des fichiers dans : $TARGET_DIR"

    # On utilise find avec -print0 pour gérer les fichiers avec espaces ou caractères spéciaux
    find "$TARGET_DIR" -maxdepth 1 -type f -print0 | while IFS= read -r -d '' file; do
     # Ignore le fichier log et les fichiers déjà dans un sous-dossier de tri
        if [[ "$file" == "$LOG_FILE" ]] || [[ "$file" =~ /Images/|/PDFs/|/Archives/|/Documents/|/Autres/ ]]; then
            continue
        fi
        
        mime_type=$(file --mime-type -b "$file")
        dest_folder=$(get_destination_folder "$mime_type")

        base_name=$(basename "$file")
        dest_path="$TARGET_DIR/$dest_folder/$base_name"

        # Empêche l’écrasement de fichiers existants : ajoute un timestamp si le fichier existe déjà
        if [ -e "$dest_path" ]; then
            extension="${base_name##*.}"
            name="${base_name%.*}"
            dest_path="$TARGET_DIR/$dest_folder/${name}_$(date +%s).${extension}"
        fi

        if [ "$DRY_RUN" = true ]; then
            echo "[TEST] $file → $dest_path"
        else
            mv "$file" "$dest_path" 2>/dev/null
            if [ $? -eq 0 ]; then
                log_action "Déplacé: $base_name → $dest_folder/"
            else
                log_action "Erreur: Impossible de déplacer $base_name"
            fi
        fi
    done
}

# === Analyse des arguments utilisateur ===
parse_args() {
    for arg in "$@"; do
        case "$arg" in
            -t|--test) DRY_RUN=true ;;
            -h|--help) show_help; exit 0 ;;
            /*) TARGET_DIR="$arg" ;;
            *) echo "❌ Option inconnue : $arg"; show_help; exit 1 ;;
        esac
    done
}

# === MAIN : point d'entrée du script ===
parse_args "$@"

# Vérification que le dossier cible existe
if [ ! -d "$TARGET_DIR" ]; then
    echo "❌ Erreur : le dossier '$TARGET_DIR' n'existe pas."
    exit 1
fi

# Initialisation du fichier log
LOG_FILE="$TARGET_DIR/file_tidier.log"
touch "$LOG_FILE" || { echo "❌ Erreur : impossible de créer le fichier log."; exit 1; }

# Création des sous-dossiers si besoin
create_folders

# Lancement du traitement
process_files

echo "✅ Tri terminé. Voir le journal : $LOG_FILE"