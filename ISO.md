# RafOS - Guide ISO

Ce guide explique comment créer et utiliser l'image ISO bootable de RafOS.

## 🎯 Pourquoi utiliser l'ISO ?

L'image ISO offre plusieurs avantages par rapport à l'image floppy :

1. **Compatibilité étendue** - Fonctionne sur plus de machines virtuelles et matériels modernes
2. **Distribution facile** - Plus facile à partager et distribuer
3. **Gravure CD/DVD** - Peut être gravé sur un disque optique
4. **Support VM moderne** - Meilleur support dans VirtualBox, VMware, Hyper-V, etc.
5. **Pas besoin de lecteur floppy** - Les lecteurs de disquettes sont obsolètes

---

## 📀 Création de l'ISO

### Prérequis

```bash
sudo apt-get install nasm genisoimage xorriso
```

### Compilation automatique

```bash
cd rafOS
./build-iso.sh
```

Le script effectue les étapes suivantes :
1. Compile le bootloader et le kernel
2. Crée l'image floppy rafos.img
3. Génère une structure ISO avec El Torito
4. Produit rafos.iso (environ 1.8 MB)

### Compilation manuelle

Si vous voulez créer l'ISO manuellement :

```bash
# 1. Compiler l'OS
./build.sh

# 2. Créer la structure ISO
mkdir -p iso_build/boot
cp rafos.img iso_build/boot/rafos.img

# 3. Générer l'ISO avec xorriso
xorriso -as mkisofs \
    -o rafos.iso \
    -b boot/rafos.img \
    -c boot/boot.cat \
    -no-emul-boot \
    -boot-load-size 4 \
    -boot-info-table \
    -R -J -V "RafOS_v2.0" \
    iso_build/

# 4. Nettoyer
rm -rf iso_build
```

---

## 🚀 Utilisation de l'ISO

### Avec QEMU

```bash
# Démarrage simple
qemu-system-i386 -cdrom rafos.iso

# Avec plus de mémoire
qemu-system-i386 -cdrom rafos.iso -m 128M

# Mode plein écran
qemu-system-i386 -cdrom rafos.iso -full-screen
```

### Avec VirtualBox

1. Créer une nouvelle VM :
   - Type : Other
   - Version : Other/Unknown
   - Mémoire : 64 MB (minimum)
   - Pas de disque dur nécessaire

2. Dans les paramètres :
   - Stockage → Contrôleur IDE → Ajouter un lecteur optique
   - Sélectionner rafos.iso
   - Démarrer la VM

### Avec VMware

1. Créer une nouvelle VM :
   - Type : Other
   - Version : Other
   - Mémoire : 64 MB

2. Paramètres CD/DVD :
   - Utiliser un fichier image ISO
   - Parcourir et sélectionner rafos.iso
   - Connecter au démarrage

### Avec Hyper-V (Windows)

1. Créer une VM Génération 1 :
   - Mémoire : 64 MB
   - Pas de disque dur

2. Paramètres :
   - Lecteur DVD → Fichier image
   - Sélectionner rafos.iso
   - Ordre de démarrage : CD en premier

### Sur machine physique

#### Graver sur CD/DVD

**Linux :**
```bash
# Avec cdrecord
cdrecord -v dev=/dev/sr0 rafos.iso

# Avec wodim
wodim -v dev=/dev/sr0 rafos.iso

# Avec Brasero (GUI)
brasero rafos.iso
```

**Windows :**
- Clic droit sur rafos.iso → Graver l'image disque
- Ou utiliser un logiciel comme ImgBurn, CDBurnerXP

**macOS :**
```bash
# Avec hdiutil
hdiutil burn rafos.iso
```

#### Démarrer depuis le CD/DVD

1. Insérer le CD/DVD gravé
2. Redémarrer l'ordinateur
3. Appuyer sur F12, F2, ou DEL pour accéder au menu de boot
4. Sélectionner le lecteur CD/DVD
5. RafOS devrait démarrer

---

## 🔧 Spécifications techniques de l'ISO

### Format
- **Type** : ISO 9660 avec extensions Rock Ridge et Joliet
- **Boot** : El Torito no-emulation mode
- **Volume ID** : RafOS_v2.0
- **Taille** : ~1.8 MB

### Structure interne
```
rafos.iso
├── boot/
│   ├── rafos.img      # Image floppy bootable (1.44 MB)
│   └── boot.cat       # Catalogue de boot El Torito
└── [métadonnées ISO]
```

### Processus de boot

1. Le BIOS charge le catalogue de boot El Torito
2. El Torito charge rafos.img comme image de boot
3. L'image floppy virtuelle démarre normalement
4. Le bootloader (boot.bin) est exécuté
5. Le kernel (kernel.bin) est chargé en mémoire
6. RafOS démarre

---

## 📊 Comparaison des formats

| Caractéristique | Image Floppy | Image ISO |
|----------------|--------------|-----------|
| Taille | 1.44 MB | ~1.8 MB |
| Support VM | Limité | Excellent |
| Distribution | Difficile | Facile |
| Gravure CD | Non | Oui |
| Matériel moderne | Rare | Commun |
| Boot UEFI | Non | Non (BIOS uniquement) |

---

## 🐛 Dépannage

### L'ISO ne démarre pas dans VirtualBox

- Vérifier que la VM est de Type "Other" et non "Linux" ou "Windows"
- Activer "Activer EFI" peut parfois aider (mais RafOS est BIOS seulement)
- S'assurer que le CD est en premier dans l'ordre de boot

### L'ISO ne démarre pas sur machine réelle

- RafOS nécessite le mode BIOS Legacy (pas UEFI)
- Dans le BIOS, désactiver Secure Boot
- Mettre le mode de démarrage en "Legacy" ou "CSM"
- S'assurer que le lecteur CD est en premier dans l'ordre de boot

### Écran noir après le boot

- C'est normal ! RafOS démarre en mode texte
- Attendre quelques secondes pour l'animation de boot
- Si rien n'apparaît après 10 secondes, essayer de recréer l'ISO

### Erreur "Boot failed"

- Vérifier que l'ISO a été créé correctement avec build-iso.sh
- Vérifier que rafos.img existe avant de créer l'ISO
- Recréer l'ISO en utilisant le script

---

## 💡 Conseils d'utilisation

### Pour tester rapidement
```bash
# Créer et lancer en une commande
./build-iso.sh && qemu-system-i386 -cdrom rafos.iso
```

### Pour distribuer
- Compresser l'ISO : `gzip rafos.iso` → `rafos.iso.gz` (~600 KB)
- Créer une checksum : `sha256sum rafos.iso > rafos.iso.sha256`

### Pour développement
- Utiliser l'image floppy pour un cycle de développement plus rapide
- Créer l'ISO seulement pour la distribution finale

---

## 📝 Notes importantes

1. **UEFI vs BIOS** : RafOS est un OS 16-bit qui ne supporte que le mode BIOS Legacy. Il ne démarrera pas sur des systèmes UEFI purs sans mode de compatibilité CSM.

2. **Limitations** : Toutes les limitations de RafOS s'appliquent également à l'ISO :
   - Mode texte uniquement (80x25)
   - Maximum 10 fichiers
   - 512 bytes max par fichier
   - Pas de persistance (tout en RAM)

3. **Taille de l'ISO** : L'ISO est plus grand que l'image floppy car il contient des métadonnées ISO supplémentaires et le catalogue de boot El Torito.

---

Créé pour RafOS v2.0 Advanced - Système d'exploitation éducatif en assembleur x86
