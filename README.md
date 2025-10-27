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
