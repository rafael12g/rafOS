# 🖥️ RafOS

<div align="center">

  ____       __  ___  _____ 
 |  _ \ __ _ / _|/ _ \/ ____|
 | |_) / _` | |_| | | (___  
 |  _ < (_| |  _| |_| |\___ \
 |_| \_\__,_|_|  \___/ ____)_|
                      |_____/ 

Un système d'exploitation minimaliste x86 32-bit avec shell interactif

[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-x86-lightgrey.svg)]()
[![Language](https://img.shields.io/badge/language-C%20%2B%20ASM-orange.svg)]()

</div>

---

## 📋 Table des Matières
- [À propos](#-à-propos)
- [Fonctionnalités](#-fonctionnalités)
- [Prérequis](#-prérequis)
- [Installation](#-installation)
- [Compilation](#-compilation)
- [Utilisation](#-utilisation)
- [Commandes disponibles](#-commandes-disponibles)
- [Architecture](#-architecture)
- [Structure du projet](#-structure-du-projet)
- [Développement](#-développement)
- [Dépannage](#-dépannage)
- [Configuration minimale et recommandée](#-configuration-minimale-et-recommandée)
- [Contribuer](#-contribuer)
- [Licence](#-licence)
- [Auteur](#-auteur)
- [Remerciements](#-remerciements)
- [Statistiques](#-statistiques)

---

## 🎯 À propos
**RafOS** est un système d'exploitation éducatif développé from scratch en **C** et **Assembly x86**.  
Il démarre depuis un **bootloader custom**, passe en **mode protégé 32-bit** et offre un **shell interactif**.

### Pourquoi RafOS ?
- 🎓 **Éducatif** : Comprendre les bases d'un OS (boot, mode protégé, drivers)  
- 🔧 **Minimaliste** : Code simple et lisible (~1000 lignes)  
- 💻 **Fonctionnel** : Shell avec commandes réelles  
- 🚀 **Extensible** : Architecture modulaire pour ajouter des fonctionnalités

---

## ✨ Fonctionnalités

### Core Features
- ✅ Bootloader custom écrit en Assembly NASM  
- ✅ Passage en mode protégé 32-bit avec GDT  
- ✅ Driver VGA pour affichage texte 80x25  
- ✅ Driver clavier PS/2 avec support des scancodes  
- ✅ Shell interactif avec prompt coloré  
- ✅ Gestion des commandes extensible  
- ✅ Scrolling automatique de l'écran  
- ✅ Support du Backspace et édition de ligne  

### Commandes intégrées

| Commande        | Description                             |
|-----------------|-----------------------------------------|
| help            | Affiche la liste des commandes          |
| clear           | Efface l'écran et réaffiche le banner   |
| about           | Informations sur RafOS                   |
| uptime          | Informations système (CPU, RAM, etc.)   |
| echo `<text>`   | Affiche le texte saisi                   |
| reboot          | Redémarre le shell                       |

---

## 🔧 Prérequis

### Systèmes supportés
- Linux (Ubuntu, Debian, Arch, Fedora)  
- macOS (via Homebrew)  
- WSL2 sur Windows  

### Outils nécessaires
- **Compiler C** : `gcc` (support 32-bit)  
- **Assembleur** : `nasm`  
- **Linker** : `ld` (binutils)  
- **Émulateur x86** : `qemu-system-i386`  
- **Script de build** : `python3`  

---

## 📦 Installation

### Ubuntu/Debian
```bash
sudo apt update
sudo apt install -y build-essential nasm qemu-system-x86 python3
sudo apt install -y gcc-multilib g++-multilib
Arch Linux
bash
Copier le code
sudo pacman -S base-devel nasm qemu-system-x86 python
Fedora
bash
Copier le code
sudo dnf groupinstall "Development Tools"
sudo dnf install nasm qemu-system-x86 python3
sudo dnf install glibc-devel.i686 libgcc.i686
macOS
bash
Copier le code
brew install nasm qemu python3
brew install i686-elf-gcc
Vérifiez l'installation :

bash
Copier le code
gcc --version
nasm --version
qemu-system-i386 --version
python3 --version
🚀 Compilation
Cloner le projet :

bash
Copier le code
git clone https://github.com/votre-username/rafOS.git
cd rafOS
Compiler RafOS :

bash
Copier le code
./build.py        # Compilation simple
./build.py clean  # Nettoyer et recompiler
./build.py all    # Compiler et lancer directement
Vérifier la compilation :
Un fichier os-image.bin (~10-20 KB) doit être créé.

Pour lancer :

bash
Copier le code
./build.py run    # Lancer l'OS
./build.py all    # Compiler et lancer
🎮 Utilisation
Shell interactif
text
Copier le code
raf@RafOS:~$ help
Entrée : Exécuter la commande

Backspace : Effacer le dernier caractère

Ctrl+C dans le terminal : Quitter QEMU

📖 Commandes disponibles
help : Liste des commandes

clear : Efface l’écran et réaffiche le banner

about : Infos sur RafOS

uptime : Infos système

echo <texte> : Affiche le texte

reboot : Redémarre le shell

🏗️ Architecture
mathematica
Copier le code
RafOS Architecture
┌─────────────────────────────┐
│ Kernel (kernel.c)           │
│ ├─ Shell & Command Parser   │
│ └─ Main Loop                │
├─────────────────────────────┤
│ Drivers                     │
│ ├─ Screen Driver (VGA)      │
│ └─ Keyboard Driver (PS/2)   │
├─────────────────────────────┤
│ LibC                        │
│ └─ String utilities         │
├─────────────────────────────┤
│ CPU                         │
│ └─ Port I/O (in/out)        │
├─────────────────────────────┤
│ Boot                        │
│ ├─ Bootloader               │
│ ├─ GDT Setup                │
│ ├─ Protected Mode Switch    │
│ └─ Kernel Entry Point       │
└─────────────────────────────┘
Processus de démarrage
BIOS charge le bootloader

Bootloader charge le kernel

Configuration de la GDT

Passage en mode protégé 32-bit

Saut vers kernel_main()

Initialisation des drivers

Affichage du banner et lancement du shell

📂 Structure du projet
graphql
Copier le code
rafOS/
├── boot/          # Bootloader et fichiers de démarrage
├── kernel/        # Kernel principal
├── drivers/       # Drivers matériels
├── cpu/           # Interactions CPU bas niveau
├── libc/          # Bibliothèque C minimaliste
├── build.py       # Script Python de compilation
└── README.md      # Ce fichier
🛠️ Développement
Ajouter une commande : éditer kernel/kernel.c et ajouter dans process_command()

Modifier les couleurs : drivers/screen.h

Passer en AZERTY : modifier le tableau scancode_to_ascii dans drivers/keyboard.c

Debugger : lancer QEMU avec -s -S et utiliser GDB

🐛 Dépannage
Commande non trouvée → installer le package manquant (gcc, nasm, qemu)

Écran noir → vérifier os-image.bin et recompiler

Clavier ne répond pas → cliquer dans QEMU, Ctrl+Alt+G

🖥️ Configuration minimale et recommandée
Processeur
Minimum : CPU x86 (32-bit ou 64-bit) compatible QEMU/VirtualBox

Recommandé : Processeur moderne avec VT-x / AMD-V

Exemple : Intel Core i3 / AMD Ryzen 3 ou équivalent

RAM
Minimum : 64 MB

Recommandé : 128 MB ou plus

RafOS utilise ~640 KB de mémoire conventionnelle

Le reste est pour l’émulateur et le système hôte

Stockage
Quelques Mo suffisent (~15-20 KB)

🤝 Contribuer
Forker le projet

Créer une branche : git checkout -b feature/MaFeature

Commit : git commit -m 'Ajout de MaFeature'

Push : git push origin feature/MaFeature

Ouvrir une Pull Request

Idées de contribution
Améliorer l’interface

Ajouter des commandes (ls, cat, mkdir)

Implémenter un système de fichiers

Ajouter horloge système (PIT), souris PS/2, son, réseau

📄 Licence
MIT License – voir LICENSE

👤 Auteur
Raf
GitHub: @votre-username
Email: votre-email@example.com

🌟 Remerciements
OSDev Community

QEMU

NASM

Tous les contributeurs

📊 Statistiques
Lignes de code : ~1000

Taille OS : ~15 KB

Temps de boot : < 1 seconde

Langages : C (60%), Assembly (40%)

<div align="center"> RafOS - Made with ❤️ by Raf ⭐ Star ce projet si vous le trouvez utile ! </div> ```
