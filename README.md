# RafOS v2.0 Advanced

Un système d'exploitation 16-bit complet écrit en assembleur x86 avec shell interactif, système de fichiers et utilitaires intégrés.

---

## 📋 Table des matières
- [Description](#description)
- [Fonctionnalités](#fonctionnalités)
- [Installation](#installation)
- [Utilisation](#utilisation)
- [Commandes disponibles](#commandes-disponibles)
- [Structure](#structure)

---

## 🎯 Description

RafOS est un OS minimaliste mais fonctionnel qui tourne directement sur le matériel (ou dans QEMU). Il offre :
- Shell avec prompt coloré personnalisable
- Système de fichiers en mémoire (10 fichiers max)
- Éditeur de texte intégré
- Historique de commandes (20 max)
- Variables d'environnement
- Calculatrice et utilitaires système

---

## ✨ Fonctionnalités

### 🗂️ Système de fichiers
- Gestion de fichiers en mémoire
- Navigation dans les répertoires
- Création/suppression/lecture de fichiers
- Éditeur de texte avec sauvegarde
- Support des scripts `.sh`

### 💻 Shell avancé
- Prompt personnalisable : `user@host:dir$`
- Coloration syntaxique
- Historique navigable (↑/↓)
- Auto-complétion (Tab)
- Variables d'environnement
- Exécution de scripts

### 🛠️ Utilitaires
- Calculatrice (+, -, ×, ÷)
- Affichage de l'heure système
- Moniteur mémoire
- Générateur de sons (beep)
- Animation de boot

---

## 📦 Installation

### Prérequis
- `nasm` (assembleur)
- `qemu-system-i386` (émulateur)

### Compilation
```bash
# Compiler le bootloader
nasm -f bin boot.asm -o boot.bin

# Compiler le kernel
nasm -f bin kernel.asm -o kernel.bin

# Créer l'image disque
cat boot.bin kernel.bin > rafos.img
dd if=/dev/zero bs=512 count=2847 >> rafos.img
Lancement
qemu-system-i386 -fda rafos.img

🚀 Utilisation
Au démarrage, vous verrez :
================================
       RafOS v2.0 Advanced     
================================
Welcome! Type "help"

user@rafos:/$
Tapez help pour voir toutes les commandes disponibles.

📝 Commandes disponibles
Système de fichiers



Commande
Description
Exemple



ls
Liste les fichiers
ls


pwd
Répertoire actuel
pwd


cd
Changer de répertoire
cd /home


mkdir
Créer un dossier
mkdir docs


touch
Créer un fichier
touch test.txt


cat
Afficher un fichier
cat readme.txt


edit
Éditer un fichier
edit file.txt


rm
Supprimer
rm file.txt


cp
Copier
cp src.txt dst.txt


mv
Déplacer/Renommer
mv old.txt new.txt


Shell



Commande
Description
Exemple



echo
Afficher du texte
echo Hello World


set
Définir variable
set USER=raf


env
Variables d'env.
env


history
Historique
history


Utilitaires



Commande
Description



calc
Calculatrice interactive


time
Afficher l'heure


mem
Mémoire disponible


beep
Émettre un son


about
Infos sur l'OS


clear
Effacer l'écran


reboot
Redémarrer


help
Aide complète


Raccourcis clavier

↑ / ↓ : Naviguer dans l'historique
Tab : Auto-complétion
Backspace : Effacer
Enter : Valider
ESC : Sauvegarder (dans l'éditeur)


📂 Structure
rafOS/
├── boot.asm          # Bootloader (512 bytes)
├── kernel.asm        # Kernel principal (15 KB)
├── boot.bin          # Bootloader compilé
├── kernel.bin        # Kernel compilé
└── rafos.img         # Image disque finale (1.44 MB)
Architecture

Bootloader : Charge le kernel en mémoire à 0x1000:0x0000
Kernel : Mode réel 16-bit, interruptions BIOS
Mémoire :
0x7C00 : Bootloader
0x10000 : Kernel
Variables et buffers en fin de kernel




🎨 Personnalisation
Changer le nom d'utilisateur
set USER=votre_nom
Changer le hostname
set HOST=votre_host
Créer un script
touch script.sh
edit script.sh
# Tapez vos commandes, puis ESC
./script.sh

🐛 Limitations

Maximum 10 fichiers
Maximum 20 commandes dans l'historique
512 bytes max par fichier
Pas de système de fichiers persistant (tout en RAM)
Mode texte uniquement (80x25)


📄 Licence
Projet libre - Utilisation libre pour apprentissage et modification

👤 Auteur
RafOS - Système d'exploitation éducatif en assembleur x86

🎓 Apprentissage
Ce projet est idéal pour :

Comprendre le fonctionnement d'un OS
Apprendre l'assembleur x86
Découvrir le mode réel 16-bit
Programmer au niveau matériel
