---
name: programmes-lycee-france
description: "Lycée français : programmes officiels, fiches, exercices."
version: 1.0.0
author: Jérôme Astier (TheFabgineer)
license: MIT
metadata:
  hermes:
    tags: [education, lycee, programmes, france, bac]
    related_skills: [document-to-action-items, pdf]
---

# Programmes du lycée français (voie générale et technologique)

## When to Use

- Expliquer un chapitre, faire une fiche de révision, une série d'exercices ou un devoir surveillé de 1ère / Terminale générale.
- Vérifier si une notion est au programme, ou hors programme, avant de l'enseigner.
- Retrouver le texte officiel (BO, éduscol) d'une discipline du lycée.
- Aide à l'orientation : combinaisons de spécialités, épreuves du bac.
- Ne couvre ni le collège (cycle 4) ni l'enseignement supérieur.

## Règle n°1 : dater le programme avant de produire

Les programmes de lycée ont bougé. Deux millésimes coexistent :

| Discipline | Version en vigueur (2026-2027) |
|---|---|
| Maths — seconde, 1ère spé, Tle spé, maths intégrées à l'ES en 1ère, techno | **BO n° 14 du 2 avril 2026**, arrêté du 26-2-2026, applicable **rentrée 2026-2027** |
| Physique-chimie (2de, 1ère, Tle) | BO spécial n° 1 du 22 janvier 2019 (+ spé Tle BO spécial n° 8 du 25-7-2019) |
| SVT (2de, 1ère, Tle) | BO spécial n° 1 du 22 janvier 2019 (+ spé Tle BO spécial n° 8) |
| NSI (1ère, Tle) | BO spécial n° 1 du 22 janvier 2019 ; épreuve pratique remaniée (note du 4-7-2025, puis BO n° 38 du 8-10-2026 pour la session 2027) |
| Enseignement scientifique 1ère | **BO du 22 juin 2023** |
| Français, HG, EMC, langues, EPS | 2019, sauf œuvre au programme de français renouvelée **chaque année** |

Conséquence pratique : pour les maths, ne pas resservir une progression d'avant 2026. Le **produit scalaire et la géométrie repérée du cercle** sont passés en 1ère, et « Automatismes » est devenu une partie du programme à part entière.

Si l'année scolaire n'est pas dite, demander (un élève de 1ère en 2026-2027 suit le programme 2026).

## Anatomie d'un programme officiel

Chaque PDF suit la même trame, et c'est elle qu'il faut citer quand on produit un cours ou un contrôle :

- **Contenus / notions et contenus** : ce qui est au programme, point par point.
- **Capacités attendues** (ou « capacités exigibles ») : ce que l'élève doit savoir *faire*. C'est le vrai cahier des charges d'un exercice.
- **Exemples d'algorithme / capacités numériques** : Python ou tableur, explicitement listés.
- **Approfondissements possibles** : facultatifs, pour différencier, jamais à évaluer.
- **Capacités expérimentales** (PC, SVT) : liste fermée.

Un exercice honnête s'adosse à une capacité attendue nommée. Un exercice qui mobilise un approfondissement doit être signalé comme tel.

## Structure de la voie générale (post-réforme 2019)

- Pas de séries. « 1ère S » n'existe plus : dire « 1ère générale, spé Maths / PC / SVT ».
- Tronc commun en 1ère : français, histoire-géo, EMC, 2 langues vivantes, EPS, **enseignement scientifique** (et maths intégrées à l'ES pour qui ne prend pas la spé maths), accompagnement à l'orientation.
- 3 enseignements de spécialité en 1ère (4h à 6h), 2 conservés en Terminale.
- La spécialité abandonnée en fin de 1ère n'a pas d'épreuve terminale : elle compte dans le contrôle continu.
- Profil « scientifique » = Maths + Physique-chimie + SVT (ou NSI / SI à la place de la SVT).
- Épreuves anticipées de français en fin de 1ère (écrit + oral).

Barème général du bac : 40 % contrôle continu, 60 % épreuves finales. Vérifier les aménagements de la session en cours sur education.gouv.fr avant d'affirmer un coefficient.

## Workflow

1. **Cadrer** : niveau, discipline, spécialité ou tronc commun, année scolaire, objectif (comprendre un chapitre, fiche de révision, série d'exos, devoir surveillé, aide à l'orientation).
2. **Récupérer le texte officiel** : `scripts/fetch_programmes.sh` télécharge les PDF dans le dossier courant, ou piocher les URLs dans `references/sources-officielles.md`.
3. **Lire la bonne colonne** : contenus = quoi, capacités attendues = jusqu'où. Ne pas dépasser.
4. **Produire** en nommant la capacité visée et en signalant les approfondissements.
5. **Vérifier** : chaque notion de la fiche/exo se retrouve dans le PDF. Si une notion n'y est pas, elle est hors programme pour ce niveau — le dire.

## Chapitres de référence (1ère générale, profil scientifique)

Détail et liens dans `references/programmes-1ere-generale-2026.md` :

- **Maths spé (2026)** : algèbre (suites, second degré) · analyse (dérivation, variations, exponentielle, trigonométrie) · géométrie (calcul vectoriel et produit scalaire, géométrie repérée) · probas-stats (conditionnelles et indépendance, variables aléatoires) · transversal (logique, algorithmique et listes Python, automatismes).
- **PC spé (2019)** : 4 thèmes — constitution et transformations de la matière · mouvement et interactions · énergie, conversions et transferts · ondes et signaux ; plus « mesure et incertitudes » (type A et B).
- **SVT spé (2019)** : 3 thèmes — transmission, variation et expression du patrimoine génétique · enjeux planétaires contemporains · corps humain et santé.
- **NSI (2019)** : types et valeurs de base · types construits · tables · interaction homme-machine sur le Web · architectures et OS · langages et programmation · algorithmique. Python 3.
- **ES 1ère (2023)** et **maths intégrées à l'ES (2026)** : pour les élèves sans spé maths.

## Ressources libres utilisables

Voir `references/ressources-libres.md` (Bacomathiques, MathALÉA, NSI-Clemenceau) avec leurs licences — un cours de prof déposé sur GitHub reste protégé : citation, pas recopie.

## Pièges

- Confondre **contenus** et **capacités attendues** : c'est l'erreur qui produit des exercices hors programme.
- Confondre **spécialité** et **enseignement scientifique** : deux programmes distincts en 1ère.
- Utiliser un manuel ou un site d'avant 2026 pour les maths de 1ère.
- « Programme de 1ère » sans préciser la voie : la voie techno (STMG, STI2D, ST2S…) a ses propres programmes.
- Le programme de français de 1ère liste des **œuvres** qui changent chaque année : ne jamais les citer de mémoire, vérifier sur éduscol.
