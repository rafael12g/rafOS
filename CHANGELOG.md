# RafOS v2.0 - Changelog

## Version 2.0 avec Addons et Support ISO

### 🎮 Nouveaux Addons (6)

#### 1. Fortune - Citations Inspirantes
- **Commande:** `fortune`
- **Description:** Affiche une citation aléatoire parmi 8 citations motivantes
- **Implémentation:** Génération pseudo-aléatoire basée sur l'horloge BIOS
- **Citations incluses:**
  - "Think different, code better!"
  - "The best way to predict the future is to invent it."
  - "Good code is its own best documentation."
  - "Simplicity is the ultimate sophistication."
  - "Make it work, make it right, make it fast."
  - "Programs must be written for people to read."
  - "Keep it simple, keep it smart!"
  - "Every expert was once a beginner."

#### 2. Date - Affichage de la Date
- **Commande:** `date`
- **Description:** Affiche la date système au format MM/DD/CCYY
- **Implémentation:** Lecture BIOS via INT 0x1A fonction 0x04
- **Format de sortie:** `Date: 11/05/2025`

#### 3. Uptime - Temps de Fonctionnement
- **Commande:** `uptime`
- **Description:** Affiche le temps écoulé depuis le démarrage en secondes
- **Implémentation:** Calcul basé sur les ticks BIOS (18.2 ticks/seconde)
- **Format de sortie:** `Uptime: 1234 seconds`

#### 4. Color - Changement de Couleur
- **Commande:** `color [0-15]`
- **Description:** Change la couleur du texte du shell
- **Palette complète:** 16 couleurs VGA
- **Fonctionnalités:**
  - Sans argument: affiche la liste des couleurs
  - Avec argument: change la couleur active
- **Exemple:** `color 14` (texte jaune)

#### 5. Snake - Jeu Snake (Demo)
- **Commande:** `snake`
- **Description:** Animation d'un serpent se déplaçant
- **Type:** Démo animée (non interactive dans cette version)
- **Caractéristiques:**
  - Animation fluide
  - Écran plein
  - 10 itérations d'animation

#### 6. Guess - Jeu de Devinettes
- **Commande:** `guess`
- **Description:** Jeu interactif de devinette de nombre
- **Règles:**
  - Nombre aléatoire entre 1 et 10
  - Indications "too high" / "too low"
  - Compteur d'essais
  - Félicitations à la victoire
- **Implémentation:** Génération aléatoire via ticks BIOS

---

### 📀 Support ISO Bootable

#### Nouveaux Scripts
1. **build-iso.sh** - Génération automatique d'ISO
   - Compile l'OS
   - Crée la structure ISO
   - Génère un ISO El Torito bootable
   - Taille de sortie: ~1.8 MB

2. **run-iso.sh** - Lancement rapide en QEMU
   - Test automatique de l'ISO
   - Messages d'aide pour les raccourcis clavier

#### Spécifications de l'ISO
- **Format:** ISO 9660 avec Rock Ridge et Joliet
- **Boot:** El Torito no-emulation mode
- **Volume ID:** RafOS_v2.0
- **Taille:** 904 secteurs (~1.8 MB)
- **Compatibilité:**
  - ✅ QEMU
  - ✅ VirtualBox
  - ✅ VMware
  - ✅ Hyper-V
  - ✅ Gravure CD/DVD
  - ✅ Boot sur matériel réel (BIOS Legacy)

---

### 📚 Documentation Ajoutée

1. **ADDONS.md** - Guide complet des addons
   - Description détaillée de chaque addon
   - Exemples d'utilisation
   - Détails techniques d'implémentation

2. **ISO.md** - Guide complet ISO
   - Instructions de création
   - Utilisation avec différents hyperviseurs
   - Gravure CD/DVD
   - Dépannage
   - Comparaison floppy vs ISO

3. **README.md** - Mise à jour
   - Section Addons ajoutée
   - Instructions ISO ajoutées
   - Structure de fichiers mise à jour
   - Options de compilation multiples

---

### 🛠️ Améliorations du Système

#### Système d'Aide Étendu
- Nouvelle catégorie **[Addons]** dans `help`
- 6 nouvelles entrées d'aide
- Documentation cohérente avec le reste du système

#### Structure du Code
- **kernel.asm:** +~250 lignes de code
- Toutes les fonctions suivent les conventions existantes
- Utilisation des fonctions utilitaires (print, getchar, etc.)
- Code bien commenté et organisé

#### Optimisation de Taille
- Kernel final: **15360 bytes** (exactement à la limite!)
- Pas de dépassement de la taille maximale configurée
- Code optimisé pour l'espace

---

### 🔧 Gestion du Projet

#### .gitignore Ajouté
Exclusions:
- Fichiers binaires compilés (*.bin)
- Images générées (*.img, *.iso)
- Répertoires temporaires (iso_build/)
- Fichiers d'éditeur (.vscode/, .idea/, *.swp)
- Fichiers système (.DS_Store, Thumbs.db)

#### Scripts de Build
- ✅ build.sh - Compilation floppy
- ✅ build-iso.sh - Compilation ISO
- ✅ run.sh - Test floppy
- ✅ run-iso.sh - Test ISO

---

### 📊 Statistiques du Projet

#### Tailles de Fichiers
- **boot.asm:** 347 bytes
- **kernel.asm:** 33 KB (source)
- **boot.bin:** 512 bytes (compilé)
- **kernel.bin:** 15360 bytes (compilé)
- **rafos.img:** 1.44 MB (image floppy)
- **rafos.iso:** 1.8 MB (image ISO)

#### Lignes de Code Ajoutées
- kernel.asm: ~250 lignes
- Documentation: ~500 lignes
- Scripts: ~100 lignes
- **Total:** ~850 lignes

#### Nombre de Commandes
- Commandes système originales: 19
- Nouvelles commandes (addons): 6
- **Total de commandes:** 25

---

### 🚀 Utilisation Rapide

#### Compilation et Test Floppy
```bash
cd rafOS
./build.sh
./run.sh
```

#### Compilation et Test ISO
```bash
cd rafOS
./build-iso.sh
./run-iso.sh
```

#### Test dans VirtualBox
```bash
./build-iso.sh
# Puis monter rafos.iso dans VirtualBox
```

---

### 🎯 Points Forts de cette Version

1. ✅ **Addons variés** - Entertainment et utilitaires
2. ✅ **Support ISO complet** - Distribution facile
3. ✅ **Documentation exhaustive** - 3 fichiers MD détaillés
4. ✅ **Taille optimisée** - Exactement à la limite
5. ✅ **Scripts automatisés** - Build et test simplifiés
6. ✅ **Compatibilité large** - Floppy et ISO
7. ✅ **Code propre** - Bien organisé et commenté
8. ✅ **Repo propre** - .gitignore approprié

---

### 🔮 Améliorations Futures Possibles

1. **Snake interactif** - Version jouable avec WASD
2. **Plus de jeux** - Pendu, Tic-Tac-Toe, Puissance 4
3. **Calculatrice scientifique** - Fonctions avancées
4. **Éditeur de code** - Coloration syntaxique
5. **Support UEFI** - Modernisation du boot
6. **Système de fichiers persistant** - Sauvegarde sur disque
7. **Support réseau** - Communication basique
8. **Mode graphique** - VGA 320x200

---

## Installation et Utilisation

Voir les fichiers de documentation:
- **README.md** - Guide général
- **ADDONS.md** - Guide des addons
- **ISO.md** - Guide ISO

---

Créé pour RafOS v2.0 Advanced
Développé en assembleur x86 16-bit
Système d'exploitation éducatif
