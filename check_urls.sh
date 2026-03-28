#!/bin/bash

# Fichiers
input_file="Listing_raw.txt"
adguard_file="AdGuard_games_list.txt"

# Vérification des URL
while IFS= read -r url; do
    if [[ -n "$url" ]]; then
        # Test de l'URL avec wget (sans téléchargement, sans timeout)
        wget --spider --timeout=5 --tries=1 "$url" &> /dev/null

        if [[ $? -ne 0 ]]; then
            echo "❌ URL invalide : $url"

            # Supprimer la ligne de Listing_raw.txt
            sed -i '' "\|^${url}$|d" "$input_file"

            # Chercher et supprimer la ligne correspondante dans AdGuard_games_list.txt
            matched_line=$(grep -nF "$url" "$adguard_file" | head -1)
            if [[ -n "$matched_line" ]]; then
                line_num=$(echo "$matched_line" | cut -d: -f1)
                line_content=$(echo "$matched_line" | cut -d: -f2-)
                sed -i '' "${line_num}d" "$adguard_file"
                echo "   Supprimé de $adguard_file : $line_content"
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