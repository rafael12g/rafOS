# RafOS Addons Guide

Cette version de RafOS inclut 6 nouveaux addons qui étendent les fonctionnalités du système.

## 📋 Liste des Addons

### 1. Fortune - Citations Inspirantes
```
fortune
```
Affiche une citation aléatoire parmi 8 citations inspirantes pour les développeurs.

**Exemples de citations:**
- "Think different, code better!"
- "The best way to predict the future is to invent it."
- "Good code is its own best documentation."
- Et 5 autres citations motivantes!

---

### 2. Date - Affichage de la Date
```
date
```
Affiche la date système actuelle au format MM/DD/CCYY en utilisant l'horloge BIOS.

**Exemple de sortie:**
```
Date: 11/05/2025
```

---

### 3. Uptime - Temps de Fonctionnement
```
uptime
```
Affiche le temps de fonctionnement du système en secondes depuis le dernier démarrage (basé sur les ticks BIOS).

**Exemple de sortie:**
```
Uptime: 1234 seconds
```

---

### 4. Color - Changement de Couleur
```
color [0-15]
```
Change la couleur du texte affiché dans le shell.

**Palette de couleurs:**
- 0 = Black (Noir)
- 1 = Blue (Bleu)
- 2 = Green (Vert)
- 3 = Cyan
- 4 = Red (Rouge)
- 5 = Magenta
- 6 = Brown (Marron)
- 7 = Gray (Gris)
- 8 = Dark Gray (Gris foncé)
- 9 = Light Blue (Bleu clair)
- 10 = Light Green (Vert clair)
- 11 = Light Cyan (Cyan clair)
- 12 = Light Red (Rouge clair)
- 13 = Light Magenta (Magenta clair)
- 14 = Yellow (Jaune)
- 15 = White (Blanc)

**Exemples:**
```
color 14    # Texte jaune
color 10    # Texte vert clair
color 15    # Texte blanc (par défaut)
```

Sans argument, affiche la liste des couleurs disponibles.

---

### 5. Snake - Jeu Snake (Démo)
```
snake
```
Lance une démonstration animée d'un serpent se déplaçant à l'écran.

**Caractéristiques:**
- Animation simple du serpent
- Affichage en plein écran
- Appuyez sur n'importe quelle touche pour revenir au shell

**Note:** Cette version est une démo animée. Une version interactive complète pourrait être ajoutée dans le futur!

---

### 6. Guess - Jeu de Devinettes
```
guess
```
Jeu interactif où vous devez deviner un nombre entre 1 et 10.

**Comment jouer:**
1. Le système choisit un nombre aléatoire entre 1 et 10
2. Vous entrez votre supposition
3. Le jeu vous indique si votre nombre est trop haut ou trop bas
4. Continuez jusqu'à trouver le bon nombre
5. Le jeu affiche le nombre d'essais à la fin

**Exemple de session:**
```
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

## 🎯 Utilisation dans le Shell

Toutes les commandes sont accessibles directement depuis le prompt RafOS:

```
user@rafos:/$ fortune
Think different, code better!

user@rafos:/$ date
Date: 11/05/2025

user@rafos:/$ uptime
Uptime: 456 seconds

user@rafos:/$ color 14
Text color changed!

user@rafos:/$ snake
[Lance le jeu Snake]

user@rafos:/$ guess
[Lance le jeu de devinettes]
```

---

## 🔧 Détails Techniques

### Taille du Kernel
Le kernel avec tous les addons fait exactement **15360 bytes** (15 KB), ce qui correspond à la taille maximale configurée.

### Implémentation
- **Fortune:** Utilise l'horloge BIOS pour générer un index pseudo-aléatoire
- **Date:** Lit la date via l'interruption BIOS 0x1A (fonction 0x04)
- **Uptime:** Calcule le temps écoulé basé sur les ticks BIOS (18.2 ticks/seconde)
- **Color:** Modifie la variable globale `color` utilisée par la fonction `print`
- **Snake:** Animation simple avec boucle de délai
- **Guess:** Génération de nombre aléatoire basée sur les ticks BIOS

### Intégration
Tous les addons sont intégrés directement dans le kernel (`kernel.asm`) et suivent la même architecture que les commandes système existantes.

---

## 📝 Notes

- Les addons sont conçus pour être légers et ne pas dépasser la limite de 15 KB du kernel
- Toutes les commandes sont documentées dans le système d'aide (commande `help`)
- Les addons utilisent les fonctions utilitaires existantes (print, getchar, etc.)
- Le code est écrit en assembleur x86 16-bit pour compatibilité avec l'architecture RafOS

---

## 🚀 Prochaines Améliorations Possibles

1. **Snake interactif** - Version jouable avec contrôles au clavier
2. **Plus de jeux** - Pendu, Tic-Tac-Toe, etc.
3. **Calculatrice étendue** - Support des fonctions scientifiques
4. **Éditeur de couleurs** - Mode interactif pour choisir les couleurs
5. **Générateur de mots de passe** - Utilitaire de sécurité
6. **Timer/Chronomètre** - Outil de gestion du temps

---

Créé pour RafOS v2.0 Advanced - Système d'exploitation éducatif en assembleur x86
