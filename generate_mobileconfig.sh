#!/bin/bash

cd "$(dirname "$0")"

listing_file="Domain_list_raw.txt"
output_file="GamesStreamingSocialFilter_Apple.mobileconfig"

# UUID unique pour le payload
payload_uuid=$(uuidgen)
profile_uuid=$(uuidgen)
content_filter_uuid=$(uuidgen)

# Générer les entrées DenyListURLs
deny_entries=""
while IFS= read -r domain; do
    domain=$(echo "$domain" | tr -d '[:space:]')
    if [[ -n "$domain" ]]; then
        deny_entries="${deny_entries}				<string>https://${domain}</string>
				<string>http://${domain}</string>
"
    fi
done < "$listing_file"

cat > "$output_file" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>PayloadDisplayName</key>
	<string>Games, Streaming &amp; Social Filter</string>
	<key>PayloadDescription</key>
	<string>Bloque les sites de jeux vidéo, de streaming et les réseaux sociaux</string>
	<key>PayloadIdentifier</key>
	<string>com.gamestreamingsocial.webcontentfilter</string>
	<key>PayloadType</key>
	<string>Configuration</string>
	<key>PayloadUUID</key>
	<string>${profile_uuid}</string>
	<key>PayloadVersion</key>
	<integer>1</integer>
	<key>PayloadContent</key>
	<array>
		<dict>
			<key>PayloadType</key>
			<string>com.apple.webcontent-filter</string>
			<key>PayloadIdentifier</key>
			<string>com.gamestreamingsocial.webcontentfilter.filter</string>
			<key>PayloadUUID</key>
			<string>${payload_uuid}</string>
			<key>PayloadVersion</key>
			<integer>1</integer>
			<key>PayloadDisplayName</key>
			<string>Games, Streaming &amp; Social Web Filter</string>
			<key>ContentFilterUUID</key>
			<string>${content_filter_uuid}</string>
			<key>FilterType</key>
			<string>BuiltIn</string>
			<key>AutoFilterEnabled</key>
			<false/>
			<key>DenyListURLs</key>
			<array>
${deny_entries}			</array>
		</dict>
	</array>
</dict>
</plist>
EOF

count=$(grep -c . "$listing_file")
echo "✅ $output_file généré avec $count domaines."
