# AdGuard Games, Streaming & Social Filter

---

## 🇫🇷 Français

### Description

Cette liste regroupe plus de **4600 domaines** liés aux jeux vidéo en ligne, jeux flash, jeux navigateur, plateformes de jeux, sites de streaming et réseaux sociaux.
Elle a été conçue pour **contrôler l'accès dans les établissements scolaires** (écoles, collèges, lycées) et les environnements d'entreprise, en particulier pour les établissements **sans MDM** souhaitant filtrer le web via AdGuard Home ou un profil de configuration Apple.

### Fichiers

| Fichier | Description |
|--------|-------------|
| `AdGuard_games_streaming_social_list.txt` | Liste principale au format AdGuard (`\|\|domain^`) — jeux, streaming et réseaux sociaux |
| `Domain_list_raw.txt` | Liste brute des domaines (un par ligne) |
| `GamesStreamingSocialFilter_Apple.mobileconfig` | Profil de configuration Apple pour appareils iOS/iPadOS |

### Utilisation

#### AdGuard / AdGuard Home
Importer `AdGuard_games_streaming_social_list.txt` comme liste de blocage personnalisée.

#### Apple (iOS / iPadOS)
Installer `GamesStreamingSocialFilter_Apple.mobileconfig` sur l'appareil.
Le profil utilise le filtre natif Apple (`com.apple.webcontent-filter`) avec `DenyListURLs`.
> Compatible appareils non supervisés (iOS 16+).

### Scripts de maintenance

| Script | Description |
|--------|-------------|
| `add_domains.sh` | Ajoute des domaines dans les deux listes. Vérifie les doublons. |
| `remove_domain.sh` | Supprime un domaine des deux listes. |
| `check_urls.sh` | Vérifie la disponibilité des URLs et supprime les domaines hors ligne. |
| `generate_mobileconfig.sh` | Génère le fichier `.mobileconfig` Apple depuis `Domain_list_raw.txt`. |

#### Ajouter des domaines
```bash
./add_domains.sh
# Collez les domaines (un par ligne), puis Ctrl+D
```

#### Supprimer un domaine
```bash
./remove_domain.sh
# Saisissez le domaine à supprimer
```

#### Vérifier les URLs
```bash
./check_urls.sh
# Teste chaque URL, supprime automatiquement les domaines inaccessibles
```

#### Générer le profil Apple
```bash
./generate_mobileconfig.sh
# Recrée GamesStreamingSocialFilter_Apple.mobileconfig depuis Domain_list_raw.txt
```

### Sources

- [Université Toulouse 1 Capitole](http://dsi.ut-capitole.fr/blacklists/) — Fabrice Prigent
- [Shub — games-blocklist](https://gitlab.com/5hub/games-blocklist/-/blob/master/filter.txt)
- brandonlang2 — [Spiceworks Community](https://community.spiceworks.com/topic/1972247-web-filtering-in-a-high-school-my-experience-list-and-ps-script-included)
- [7R0N1X](https://github.com/7R0N1X) — contributions supplémentaires

---

## 🇬🇧 English

### Description

This list contains over **4,600 domains** related to online video games, flash games, browser games, gaming platforms, streaming sites, and social networks.
It was designed to **control access in school environments** (primary, secondary, and high schools) and corporate networks, especially for institutions **without MDM** looking to filter web access via AdGuard Home or an Apple configuration profile.

### Files

| File | Description |
|------|-------------|
| `AdGuard_games_streaming_social_list.txt` | Main blocklist in AdGuard format (`\|\|domain^`) — games, streaming & social |
| `Domain_list_raw.txt` | Raw domain list (one per line) |
| `GamesStreamingSocialFilter_Apple.mobileconfig` | Apple configuration profile for iOS/iPadOS devices |

### Usage

#### AdGuard / AdGuard Home
Import `AdGuard_games_streaming_social_list.txt` as a custom blocklist.

#### Apple (iOS / iPadOS)
Install `GamesStreamingSocialFilter_Apple.mobileconfig` on the device.
The profile uses the native Apple web content filter (`com.apple.webcontent-filter`) with `DenyListURLs`.
> Compatible with unsupervised devices (iOS 16+).

### Maintenance Scripts

| Script | Description |
|--------|-------------|
| `add_domains.sh` | Adds domains to both lists. Checks for duplicates. |
| `remove_domain.sh` | Removes a domain from both lists. |
| `check_urls.sh` | Checks URL availability and removes unreachable domains. |
| `generate_mobileconfig.sh` | Generates the Apple `.mobileconfig` file from `Domain_list_raw.txt`. |

#### Add domains
```bash
./add_domains.sh
# Paste domains (one per line), then Ctrl+D
```

#### Remove a domain
```bash
./remove_domain.sh
# Enter the domain to remove
```

#### Check URLs
```bash
./check_urls.sh
# Tests each URL, automatically removes unreachable domains
```

#### Generate Apple profile
```bash
./generate_mobileconfig.sh
# Rebuilds GamesStreamingSocialFilter_Apple.mobileconfig from Domain_list_raw.txt
```

### Credits

- [Toulouse 1 Capitole University](http://dsi.ut-capitole.fr/blacklists/) — Fabrice Prigent
- [Shub — games-blocklist](https://gitlab.com/5hub/games-blocklist/-/blob/master/filter.txt)
- brandonlang2 — [Spiceworks Community](https://community.spiceworks.com/topic/1972247-web-filtering-in-a-high-school-my-experience-list-and-ps-script-included)
- [7R0N1X](https://github.com/7R0N1X) — additional contributions
