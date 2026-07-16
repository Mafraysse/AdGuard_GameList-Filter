#!/bin/bash

cd "$(dirname "$0")"

listing_file="Domain_list_raw.txt"
adguard_file="AdGuard_games_streaming_social_list.txt"

echo "Collez les domaines (un par ligne), puis appuyez sur Entrée puis Ctrl+D :"
echo ""

added=0

while IFS= read -r domain; do
    domain=$(echo "$domain" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')
    if [[ -n "$domain" ]]; then
        if grep -qF "$domain" "$listing_file"; then
            echo "⚠️  Déjà présent : $domain"
        else
            echo "$domain" >> "$listing_file"
            echo "||${domain}^" >> "$adguard_file"
            echo "✅ Ajouté : $domain"
            ((added++))
        fi
    fi
done

echo ""
echo "$added domaine(s) ajouté(s)."
