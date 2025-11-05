# RafOS v2.0 - Quick Start Guide

## 🚀 Démarrage Rapide

### Option 1: Image Floppy (Rapide pour le développement)
```bash
cd rafOS
./build.sh    # Compile l'OS
./run.sh      # Lance dans QEMU
```

### Option 2: Image ISO (Meilleur pour la distribution)
```bash
cd rafOS
./build-iso.sh    # Compile et crée l'ISO
./run-iso.sh      # Lance l'ISO dans QEMU
```

---

## 📝 Premiers Pas dans RafOS

Une fois l'OS démarré, vous verrez:
```
================================
       RafOS v2.0 Advanced     
================================
Welcome! Type "help"

user@rafos:/$ 
```

### Commandes Essentielles

```bash
# Voir toutes les commandes disponibles
help

# Lister les fichiers
ls

# Créer un fichier
touch test.txt

# Éditer un fichier (ESC pour sauvegarder)
edit test.txt

# Afficher un fichier
cat test.txt

# Essayer un addon
fortune
```

---

## 🎮 Tester les Addons

### Fortune - Citation Aléatoire
```bash
user@rafos:/$ fortune
Think different, code better!
```

### Date - Afficher la Date
```bash
user@rafos:/$ date
Date: 11/05/2025
```

### Uptime - Temps de Fonctionnement
```bash
user@rafos:/$ uptime
Uptime: 456 seconds
```

### Color - Changer la Couleur
```bash
user@rafos:/$ color 14
Text color changed!

user@rafos:/$ color
Usage: color [0-15]
[Liste des couleurs affichée]
```

### Snake - Jeu Snake (Démo)
```bash
user@rafos:/$ snake
[Animation du serpent]
[Appuyer sur une touche pour continuer]
```

### Guess - Jeu de Devinettes
```bash
user@rafos:/$ guess
=== NUMBER GUESSING GAME ===

I am thinking of a number between 1 and 10.

Your guess: 5
Too low! Try again.
Your guess: 8
Too high! Try again.
Your guess: 7

Congratulations! You won!
Number of tries: 3
```

---

## 🛠️ Commandes Système Utiles

### Gestion de Fichiers
```bash
ls              # Lister les fichiers
pwd             # Répertoire actuel
mkdir docs      # Créer un dossier
touch file.txt  # Créer un fichier
cat file.txt    # Afficher un fichier
edit file.txt   # Éditer un fichier
rm file.txt     # Supprimer un fichier
cp src dst      # Copier un fichier
mv old new      # Déplacer/Renommer
```

### Shell
```bash
echo Hello World    # Afficher du texte
set USER=raf       # Définir une variable
env                # Afficher les variables
history            # Historique des commandes
```

### Utilitaires
```bash
calc     # Calculatrice interactive
time     # Afficher l'heure système
mem      # Mémoire disponible
beep     # Émettre un son
about    # Informations sur RafOS
clear    # Effacer l'écran
reboot   # Redémarrer
```

---

## ⌨️ Raccourcis Clavier

- **↑/↓** : Naviguer dans l'historique
- **Tab** : Auto-complétion
- **Backspace** : Effacer
- **Enter** : Valider
- **ESC** : Sauvegarder (dans l'éditeur)

---

## 💾 Utilisation dans des VMs

### VirtualBox
1. Créer une VM "Other/Unknown"
2. Mémoire: 64 MB minimum
3. Monter `rafos.iso` comme CD-ROM
4. Démarrer

### VMware
1. Nouvelle VM "Other"
2. Monter `rafos.iso` dans le lecteur CD
3. Boot sur CD
4. Démarrer

### QEMU (ligne de commande)
```bash
# Depuis floppy
qemu-system-i386 -fda rafos.img

# Depuis ISO
qemu-system-i386 -cdrom rafos.iso

# Avec plus de mémoire
qemu-system-i386 -cdrom rafos.iso -m 128M
```

---

## 📖 Documentation Complète

- **README.md** - Vue d'ensemble et installation
- **ADDONS.md** - Guide détaillé des 6 addons
- **ISO.md** - Création et utilisation de l'ISO
- **CHANGELOG.md** - Liste des fonctionnalités

---

## 🎯 Exemples de Scripts

### Créer un Script Simple
```bash
# 1. Créer le fichier
touch script.sh

# 2. Éditer le fichier
edit script.sh

# 3. Taper vos commandes:
echo Hello from script
fortune
date

# 4. ESC pour sauvegarder

# 5. Exécuter le script
./script.sh
```

---

## 🐛 Dépannage

### L'OS ne démarre pas
- Vérifier que QEMU est installé: `qemu-system-i386 --version`
- Vérifier que les fichiers existent: `ls -lh rafos.{img,iso}`
- Recompiler: `./build.sh` ou `./build-iso.sh`

### Erreur de compilation
- Installer NASM: `sudo apt-get install nasm`
- Vérifier que vous êtes dans le bon dossier: `cd rafOS`

### ISO ne démarre pas dans VM
- Utiliser type de VM "Other" (pas Linux/Windows)
- Désactiver UEFI, utiliser BIOS Legacy
- Vérifier l'ordre de boot (CD en premier)

---

## 💡 Conseils

1. **Développement rapide**: Utilisez l'image floppy (`build.sh`)
2. **Distribution**: Créez l'ISO (`build-iso.sh`)
3. **Testez souvent**: Les commandes sont sauvegardées en RAM uniquement
4. **Explorez**: Tapez `help` pour voir toutes les commandes

---

## 🎓 Pour Apprendre

RafOS est parfait pour:
- ✅ Comprendre le boot d'un OS
- ✅ Apprendre l'assembleur x86
- ✅ Découvrir le mode réel 16-bit
- ✅ Programmer avec les interruptions BIOS
- ✅ Créer un shell interactif
- ✅ Développer un système de fichiers simple

---

**Amusez-vous bien avec RafOS v2.0!** 🚀

Pour plus d'informations, consultez les autres fichiers de documentation.
