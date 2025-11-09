# RafOS Web Browser

## Vue d'ensemble

RafOS v2.0 inclut maintenant un navigateur web textuel fonctionnel ! Ce navigateur permet de naviguer entre plusieurs pages web stockées en mémoire, avec un système de navigation complet incluant historique et liens.

## Lancement

Pour lancer le navigateur depuis le shell RafOS :

```
user@rafos:/$ browser
```

## Interface utilisateur

Le navigateur affiche :
- **En-tête** : Titre du navigateur avec version
- **Barre d'URL** : Affiche l'URL actuelle (protocole rafos://)
- **Contenu** : Page web en mode texte
- **Menu** : Options de navigation disponibles

```
============= RafOS Web Browser v1.0 =============
URL: rafos://home
==================================================

*** Welcome to RafOS Web ***

Welcome to the RafOS Web Browser!

This is a text-based web browser built into
RafOS v2.0. Navigate between pages using the
menu options below.

Features:
  * Multiple pages to explore
  * Navigation history (back button)
  * Simple URL system
  * Text-based rendering

==================================================
[1]Home [2]About [3]Docs [4]Search [B]Back [R]Refresh [Q]Quit
Enter command: 
```

## Commandes de navigation

| Touche | Action |
|--------|--------|
| `1` | Accéder à la page d'accueil |
| `2` | Accéder à la page À propos |
| `3` | Accéder à la page Documentation |
| `4` | Accéder à la page Recherche |
| `B` | Retour à la page précédente (historique) |
| `R` | Rafraîchir la page actuelle |
| `Q` | Quitter le navigateur |

## Pages disponibles

### 1. Page d'accueil (rafos://home)
Page d'accueil du navigateur avec présentation et liens rapides vers les autres pages.

### 2. Page À propos (rafos://about)
Informations détaillées sur RafOS v2.0, ses fonctionnalités et son objectif éducatif.

### 3. Documentation (rafos://docs)
Guide complet d'utilisation du navigateur avec explications des commandes.

### 4. Recherche (rafos://search)
Page de recherche listant toutes les pages disponibles dans le navigateur.

## Fonctionnalités

### Historique de navigation
- Le navigateur conserve un historique des 10 dernières pages visitées
- Utilisez la touche `B` pour revenir en arrière dans l'historique
- L'historique est réinitialisé à chaque lancement du navigateur

### Système d'URL
- Protocole personnalisé `rafos://`
- URLs simples et descriptives (home, about, docs, search)
- Affichage de l'URL actuelle dans la barre d'adresse

### Rendu de pages
- Formatage texte optimisé pour mode 80x25
- Support des sauts de ligne et formatage
- Titres en couleur pour meilleure lisibilité

## Architecture technique

### Implémentation
- Écrit en assembleur x86 16-bit
- Intégré directement dans le kernel RafOS
- Pages web stockées en mémoire (format texte)
- Taille totale : ~2KB pour le code + pages

### Limitations
- 4 pages intégrées (extensible jusqu'à ~10 pages selon mémoire)
- Pas de support réseau (pages locales uniquement)
- Mode texte uniquement (pas de graphiques)
- Historique limité à 10 pages

## Exemples d'utilisation

### Navigation basique
```
1. Lancer le navigateur : browser
2. Appuyer sur 2 pour voir la page About
3. Appuyer sur 3 pour voir la Documentation
4. Appuyer sur B pour revenir en arrière
5. Appuyer sur Q pour quitter
```

### Exploration complète
```
1. browser          # Lancer
2. 1                # Page d'accueil
3. 2                # À propos
4. 3                # Documentation
5. 4                # Recherche
6. B                # Retour à Documentation
7. B                # Retour à À propos
8. 1                # Retour à l'accueil
9. Q                # Quitter
```

## Notes de développement

Le navigateur est implémenté dans `kernel.asm` avec :
- Fonction principale : `web_browser`
- Rendu de pages : `browser_render_page`
- Gestion historique : `browser_save_history`, `browser_go_back`
- ~300 lignes de code assembleur
- Données de pages : ~1KB de texte

## Conclusion

Ce navigateur démontre qu'un système d'exploitation minimal peut offrir une expérience de navigation fonctionnelle, même dans un environnement aussi contraint qu'un OS 16-bit en mode texte. C'est un excellent exemple de programmation système bas niveau !
