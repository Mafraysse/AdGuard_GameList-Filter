#!/bin/bash

# Fichiers
input_file="Listing_raw.txt"
valid_file="valid_urls.txt"
invalid_file="invalid_urls.txt"

# Nettoyage des anciens fichiers
> "$valid_file"
> "$invalid_file"

# Vérification des URL
while IFS= read -r url; do
    if [[ -n "$url" ]]; then
        # Test de l'URL avec wget (sans téléchargement)
        wget --spider --timeout=5 --tries=1 "$url" &> /dev/null
        
        # Vérifier le code retour
        if [[ $? -eq 0 ]]; then
            echo "$url" >> "$valid_file"
        else
            echo "$url" >> "$invalid_file"
        fi
    fi
done < "$input_file"

echo "✅ Vérification terminée."
echo "📂 Fichier des URL valides : $valid_file"
echo "📂 Fichier des URL invalides : $invalid_file"