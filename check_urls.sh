#!/bin/bash

cd "$(dirname "$0")"

# Fichiers
input_file="Domain_list_raw.txt"
adguard_file="AdGuard_games_streaming_social_list.txt"

delete_exact_line() {
    local target="$1"
    local file="$2"
    local tmp

    tmp=$(mktemp "${TMPDIR:-/tmp}/adguard-filter.XXXXXX") || return 1
    if ! awk -v target="$target" '
        BEGIN { removed = 0 }
        $0 == target { removed = 1; next }
        { print }
        END { exit(removed ? 0 : 2) }
    ' "$file" > "$tmp"; then
        rm -f "$tmp"
        return 1
    fi

    if ! mv "$tmp" "$file"; then
        rm -f "$tmp"
        return 1
    fi
}

# Vérification des URL
while IFS= read -r url; do
    if [[ -n "$url" ]]; then
        # Test de l'URL avec wget (sans téléchargement, sans timeout)
        wget --spider --timeout=5 --tries=1 "$url" &> /dev/null

        if [[ $? -ne 0 ]]; then
            echo "❌ URL invalide : $url"

            # Supprimer la ligne de Domain_list_raw.txt
            if ! delete_exact_line "$url" "$input_file"; then
                echo "   Échec de suppression dans $input_file"
                exit 1
            fi

            # Supprimer la ligne correspondante dans AdGuard_games_streaming_social_list.txt
            if grep -qFx "||${url}^" "$adguard_file"; then
                if delete_exact_line "||${url}^" "$adguard_file"; then
                    echo "   Supprimé de $adguard_file : ||${url}^"
                else
                    echo "   Échec de suppression dans $adguard_file"
                    exit 1
                fi
            else
                echo "   URL non trouvée dans $adguard_file"
            fi
        else
            echo "✅ URL valide : $url"
        fi
    fi
done < <(cat "$input_file")

echo ""
echo "Vérification terminée."
