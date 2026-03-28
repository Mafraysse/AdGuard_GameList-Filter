#!/bin/bash

cd "$(dirname "$0")"

listing_file="Domain_list_raw.txt"
adguard_file="AdGuard_games_streaming_social_list.txt"

echo "Entrez le domaine à supprimer :"
read -r domain
domain=$(echo "$domain" | tr -d '[:space:]')

if [[ -z "$domain" ]]; then
    echo "Aucun domaine saisi."
    exit 1
fi

# Supprimer de Listing_raw.txt
if grep -qF "$domain" "$listing_file"; then
    line_num=$(grep -nF "$domain" "$listing_file" | head -1 | cut -d: -f1)
    sed -i '' "${line_num}d" "$listing_file"
    echo "✅ Supprimé de $listing_file"
else
    echo "⚠️  Non trouvé dans $listing_file"
fi

# Supprimer de AdGuard_games_list.txt
if grep -qF "$domain" "$adguard_file"; then
    line_num=$(grep -nF "$domain" "$adguard_file" | head -1 | cut -d: -f1)
    sed -i '' "${line_num}d" "$adguard_file"
    echo "✅ Supprimé de $adguard_file"
else
    echo "⚠️  Non trouvé dans $adguard_file"
fi

