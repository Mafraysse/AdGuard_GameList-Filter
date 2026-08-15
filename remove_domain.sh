#!/bin/bash

cd "$(dirname "$0")"

listing_file="Domain_list_raw.txt"
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

echo "Entrez le domaine à supprimer :"
read -r domain
domain=$(echo "$domain" | tr -d '[:space:]')

if [[ -z "$domain" ]]; then
    echo "Aucun domaine saisi."
    exit 1
fi

# Supprimer de Domain_list_raw.txt
if grep -qFx "$domain" "$listing_file"; then
    if delete_exact_line "$domain" "$listing_file"; then
        echo "✅ Supprimé de $listing_file"
    else
        echo "❌ Échec de suppression dans $listing_file"
        exit 1
    fi
else
    echo "⚠️  Non trouvé dans $listing_file"
fi

# Supprimer de AdGuard_games_streaming_social_list.txt
if grep -qFx "||${domain}^" "$adguard_file"; then
    if delete_exact_line "||${domain}^" "$adguard_file"; then
        echo "✅ Supprimé de $adguard_file"
    else
        echo "❌ Échec de suppression dans $adguard_file"
        exit 1
    fi
else
    echo "⚠️  Non trouvé dans $adguard_file"
fi
