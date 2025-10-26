<div align="center">

  ____       __  ___  _____ 
 |  _ \ __ _ / _|/ _ \/ ____|
 | |_) / _` | |_| | | (___  
 |  _ < (_| |  _| |_| |\___ \
 |_| \_\__,_|_|  \___/ ____)_|
                      |_____/ 
Un système d'exploitation minimaliste x86 32-bit avec shell interactif
<img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License" />
<img src="https://img.shields.io/badge/platform-x86-lightgrey.svg" alt="Platform" />
<img src="https://img.shields.io/badge/language-C%20%2B%20ASM-orange.svg" alt="Language" />
</div>


📋 Table des Matières

À propos
Fonctionnalités
Prérequis
Installation
Compilation
Utilisation
Commandes disponibles
Architecture
Structure du projet
Développement
Dépannage
Contribuer
Licence


🎯 À propos
RafOS est un système d'exploitation éducatif développé from scratch en C et Assembly x86. Il démarre directement depuis un bootloader custom, passe en mode protégé 32-bit et offre un shell interactif fonctionnel.
Pourquoi RafOS ?

🎓 Éducatif : Comprendre les bases d'un OS (boot, mode protégé, drivers)
🔧 Minimaliste : Code simple et lisible (~1000 lignes)
💻 Fonctionnel : Shell avec commandes réelles
🚀 Extensible : Architecture modulaire pour ajouter des features


✨ Fonctionnalités
Core Features

✅ Bootloader custom écrit en Assembly NASM
✅ Passage en mode protégé 32-bit avec GDT
✅ Driver VGA pour affichage texte 80x25
✅ Driver clavier PS/2 avec support des scancodes
✅ Shell interactif avec prompt coloré
✅ Gestion des commandes extensible
✅ Scrolling automatique de l'écran
✅ Support du Backspace et édition de ligne

Commandes Intégrées



Commande
Description



help
Affiche la liste des commandes


clear
Efface l'écran et réaffiche le banner


about
Informations sur RafOS


uptime
Informations système (CPU, RAM, etc.)


echo <text>
Affiche le texte saisi


reboot
Redémarre le shell



🔧 Prérequis
Systèmes supportés

Linux (Ubuntu, Debian, Arch, Fedora, etc.)
macOS (via Homebrew)
WSL2 sur Windows

Outils nécessaires
# Compiler C
gcc (avec support 32-bit)

# Assembleur
nasm

# Linker
ld (binutils)

# Émulateur x86
qemu-system-i386

# Script de build
python3

📦 Installation
Sur Ubuntu/Debian
sudo apt update
sudo apt install -y build-essential nasm qemu-system-x86 python3
sudo apt install -y gcc-multilib g++-multilib  # Support 32-bit
Sur Arch Linux
sudo pacman -S base-devel nasm qemu-system-x86 python
Sur Fedora
sudo dnf groupinstall "Development Tools"
sudo dnf install nasm qemu-system-x86 python3
sudo dnf install glibc-devel.i686 libgcc.i686  # Support 32-bit
Sur macOS
brew install nasm qemu python3
brew install i686-elf-gcc  # Cross-compiler 32-bit
Vérifier l'installation
gcc --version
nasm --version
qemu-system-i386 --version
python3 --version

🚀 Compilation
1. Cloner ou télécharger le projet
cd ~
git clone https://github.com/votre-username/rafOS.git
cd rafOS
Ou créer depuis zéro (voir Structure du projet)
2. Compiler RafOS
# Compilation simple
./build.py

# Nettoyer et recompiler
./build.py clean
./build.py

# Compiler et lancer directement
./build.py all
3. Vérifier la compilation
Si tout s'est bien passé, vous devriez voir :
==================================================
[*] Cleaning RafOS
==================================================
✅ Clean done!

==================================================
[*] Compiling bootloader
==================================================
✅ Compiling bootloader done!

...

✅ RafOS built successfully! Size: XXXXX bytes

🚀 To run: ./build.py run
🚀 Or build and run: ./build.py all
Un fichier os-image.bin doit être créé (~10-20 KB).

🎮 Utilisation
Lancer RafOS dans QEMU
# Lancer l'OS compilé
./build.py run
Utilisation du shell
Une fois RafOS démarré, vous verrez :
  ____       __  ___  _____ 
 |  _ \ __ _ / _|/ _ \/ ____|
 | |_) / _` | |_| | | (___  
 |  _ < (_| |  _| |_| |\___ \
 |_| \_\__,_|_|  \___/ ____)_|
                      |_____/ 

RafOS v1.0 - Custom Operating System
Type 'help' for available commands

raf@RafOS:~$ _
Raccourcis clavier

Entrée : Exécuter la commande
Backspace : Effacer le dernier caractère
Ctrl+C dans le terminal : Quitter QEMU


📖 Commandes disponibles
help
Affiche la liste complète des commandes disponibles.
raf@RafOS:~$ help

Available commands:
  help    - Show this message
  clear   - Clear the screen
  echo    - Repeat your input
  about   - About RafOS
  uptime  - System information
  reboot  - Restart RafOS
clear
Efface l'écran et réaffiche le banner de démarrage.
raf@RafOS:~$ clear
about
Affiche les informations sur RafOS.
raf@RafOS:~$ about

RafOS - Custom Operating System
Version: 1.0
Author: Raf
Built with: GCC, NASM, Python
Architecture: x86 (32-bit)
uptime
Affiche les informations système.
raf@RafOS:~$ uptime

System Information:
  CPU: x86 (32-bit)
  Memory: 640 KB conventional
  Video: VGA text mode 80x25
  Keyboard: PS/2
echo <texte>
Répète le texte saisi après la commande.
raf@RafOS:~$ echo Hello World!
  Hello World!
reboot
Réinitialise le shell (efface l'écran et redémarre l'interface).
raf@RafOS:~$ reboot
Rebooting RafOS...

🏗️ Architecture
Vue d'ensemble
┌─────────────────────────────────────────┐
│           RafOS Architecture            │
├─────────────────────────────────────────┤
│  Kernel (kernel.c)                      │
│  ├─ Shell & Command Parser              │
│  └─ Main Loop                           │
├─────────────────────────────────────────┤
│  Drivers                                │
│  ├─ Screen Driver (VGA text mode)       │
│  └─ Keyboard Driver (PS/2)              │
├─────────────────────────────────────────┤
│  LibC                                   │
│  └─ String utilities (strcmp, strlen)   │
├─────────────────────────────────────────┤
│  CPU                                    │
│  └─ Port I/O (in/out instructions)      │
├─────────────────────────────────────────┤
│  Boot                                   │
│  ├─ Bootloader (Real Mode)              │
│  ├─ GDT Setup                           │
│  ├─ Protected Mode Switch               │
│  └─ Kernel Entry Point                  │
└─────────────────────────────────────────┘
Processus de démarrage
1. BIOS charge le bootloader (boot_sect.asm) à 0x7c00
2. Bootloader charge le kernel depuis le disque
3. Configuration de la GDT (Global Descriptor Table)
4. Passage en mode protégé 32-bit
5. Saut vers kernel_main()
6. Initialisation des drivers (screen, keyboard)
7. Affichage du banner et lancement du shell
Mode protégé 32-bit
RafOS utilise le mode protégé avec :

Segmentation : Code segment (CS) et Data segment (DS)
Pas de pagination : Adressage direct en mémoire
Pas d'interruptions : Polling du clavier via port I/O


📂 Structure du projet
rafOS/
│
├── boot/                      # Bootloader et fichiers de démarrage
│   ├── boot_sect.asm          # Secteur de boot principal
│   ├── kernel_entry.asm       # Point d'entrée du kernel
│   ├── print_string.asm       # Affichage en mode réel (16-bit)
│   ├── print_string_pm.asm    # Affichage en mode protégé (32-bit)
│   ├── disk_load.asm          # Chargement depuis disque (BIOS)
│   ├── gdt.asm                # Global Descriptor Table
│   └── switch_to_pm.asm       # Passage en mode protégé
│
├── kernel/                    # Kernel principal
│   └── kernel.c               # Point d'entrée C, shell, commandes
│
├── drivers/                   # Drivers matériels
│   ├── screen.h               # Header du driver écran
│   ├── screen.c               # Driver VGA text mode
│   ├── keyboard.h             # Header du driver clavier
│   └── keyboard.c             # Driver clavier PS/2
│
├── cpu/                       # Interactions CPU bas niveau
│   ├── ports.h                # Header pour I/O ports
│   └── ports.c                # Instructions IN/OUT
│
├── libc/                      # Bibliothèque C minimaliste
│   ├── string.h               # Header utilitaires chaînes
│   └── string.c               # strcmp, strlen, strcpy, etc.
│
├── build.py                   # Script Python de compilation
└── README.md                  # Ce fichier
Détail des fichiers clés
boot/boot_sect.asm
Bootloader chargé par le BIOS. Charge le kernel, configure la GDT et passe en mode protégé.
kernel/kernel.c
Cœur de RafOS : boucle principale, parser de commandes, shell interactif.
drivers/screen.c
Gère l'affichage VGA : écriture en mémoire vidéo (0xB8000), scrolling, curseur.
drivers/keyboard.c
Lit les scancodes du clavier (port 0x60), les convertit en ASCII (QWERTY).
cpu/ports.c
Fonctions port_byte_in() et port_byte_out() pour interagir avec les ports I/O.
libc/string.c
Fonctions utilitaires : strcmp(), strlen(), strcpy(), strncmp().
build.py
Script automatisé de compilation (NASM + GCC + LD) et lancement QEMU.

🛠️ Développement
Ajouter une nouvelle commande

Éditer kernel/kernel.c

void cmd_macommande() {
    print("Ma nouvelle commande !\n");
}

Ajouter dans process_command()

else if (strcmp(input_buffer, "macommande") == 0) {
    cmd_macommande();
}

Recompiler et tester

./build.py all
Modifier les couleurs
Dans drivers/screen.h, vous pouvez changer les couleurs :
#define WHITE_ON_BLACK 0x0f
#define RED_ON_BLACK 0x04
#define GREEN_ON_BLACK 0x02
#define CYAN_ON_BLACK 0x0b
#define YELLOW_ON_BLACK 0x0e
Format : 0xBF où B = couleur de fond, F = couleur du texte



Code
Couleur



0
Noir


1
Bleu


2
Vert


3
Cyan


4
Rouge


5
Magenta


6
Marron


7
Gris clair


8
Gris foncé


9
Bleu clair


A
Vert clair


B
Cyan clair


C
Rouge clair


D
Magenta clair


E
Jaune


F
Blanc


Passer en AZERTY
Dans drivers/keyboard.c, modifier le tableau scancode_to_ascii :
// Exemple : remplacer 'q' par 'a', 'a' par 'q', etc.
static char scancode_to_ascii[128] = {
    0,  27, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', ')', '=', '\b',
    '\t', 'a', 'z', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '^', '$', '\n',
    0, 'q', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'u', '*',
    // ... adapter selon clavier AZERTY
};
Débugger avec GDB
# Terminal 1 : Lancer QEMU en mode debug
qemu-system-i386 -drive file=os-image.bin,format=raw,if=floppy -boot a -s -S

# Terminal 2 : Lancer GDB
gdb
(gdb) target remote localhost:1234
(gdb) break kernel_main
(gdb) continue

🐛 Dépannage
Erreur : "gcc: command not found"
# Ubuntu/Debian
sudo apt install build-essential gcc-multilib

# Arch Linux
sudo pacman -S base-devel

# macOS
xcode-select --install
Erreur : "nasm: command not found"
# Ubuntu/Debian
sudo apt install nasm

# Arch Linux
sudo pacman -S nasm

# macOS
brew install nasm
Erreur : "qemu-system-i386: command not found"
# Ubuntu/Debian
sudo apt install qemu-system-x86

# Arch Linux
sudo pacman -S qemu-system-x86

# macOS
brew install qemu
Erreur : "fatal error: sys/cdefs.h: No such file or directory"
Vous devez installer le support 32-bit pour GCC :
# Ubuntu/Debian
sudo apt install gcc-multilib g++-multilib

# Fedora
sudo dnf install glibc-devel.i686 libgcc.i686
Le clavier ne répond pas dans QEMU

Vérifiez que la fenêtre QEMU a le focus
Cliquez dans la fenêtre QEMU avant de taper
Essayez Ctrl+Alt+G pour capturer/relâcher la souris

L'écran reste noir

Vérifiez que os-image.bin existe et fait plus de 512 octets
Recompilez avec ./build.py clean puis ./build.py
Vérifiez les logs dans le terminal

Caractères bizarres à l'écran

Problème de conversion scancode → ASCII
Vérifiez votre layout clavier (QWERTY vs AZERTY)
Le driver clavier est configuré en QWERTY par défaut


🤝 Contribuer
Les contributions sont les bienvenues ! Voici comment participer :

Fork le projet
Créer une branche (git checkout -b feature/MaFeature)
Commit vos changements (git commit -m 'Ajout de MaFeature')
Push vers la branche (git push origin feature/MaFeature)
Ouvrir une Pull Request

Idées de contributions

🎨 Améliorer l'interface (couleurs, ASCII art)
📝 Ajouter des commandes (ls, cat, mkdir)
💾 Implémenter un système de fichiers simple
⏰ Ajouter une horloge système (PIT)
🖱️ Support de la souris PS/2
🔊 Driver son (PC Speaker)
🌐 Support réseau basique


📚 Ressources
Documentation

OSDev Wiki - Référence complète sur le développement d'OS
Intel x86 Manual - Documentation officielle CPU
NASM Documentation - Manuel de l'assembleur NASM

Tutoriels

Writing a Simple Operating System from Scratch - PDF complet
Bran's Kernel Development - Tutoriel classique
JamesM's Kernel Tutorial - Tutoriel avancé

Livres

Operating Systems: Three Easy Pieces (gratuit en ligne)
Modern Operating Systems - Andrew S. Tanenbaum
Operating System Concepts - Abraham Silberschatz


📄 Licence
Ce projet est sous licence MIT. Voir le fichier LICENSE pour plus de détails.
MIT License

Copyright (c) 2024 Raf

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

👤 Auteur
Raf

GitHub: @votre-username
Email: votre-email@example.com


🌟 Remerciements

OSDev Community pour la documentation et les ressources
QEMU pour l'émulateur performant
NASM pour l'assembleur open-source
Tous les contributeurs du projet


📊 Statistiques

Lignes de code : ~1000
Taille de l'OS : ~15 KB
Temps de boot : < 1 seconde
Langages : C (60%), Assembly (40%)


<div align="center">

RafOS - Made with ❤️ by Raf
⭐ Star ce projet si vous le trouvez utile !
</div>
