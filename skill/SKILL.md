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
| Langues vivantes (LVE) | **BO n° 22 du 29 mai 2025**, applicable en 1ère et Terminale depuis la rentrée 2026-2027 ; les langues régionales restent sur 2019 |
| EMC | **BO n° 24 du 13 juin 2024**, en application à tous les niveaux depuis la rentrée 2026-2027 |
| Histoire-géographie | BO spécial n° 1 du 22 janvier 2019 (annexe 2), toujours en vigueur |
| Français | Programme 2019 modifié ; épreuves redéfinies par la note de service du 11-9-2026 ; **œuvres renouvelées chaque année** |
| EPS | BO spécial n° 1 du 22 janvier 2019 + note de service du 20 février 2026 pour l'évaluation (contrôle en cours de formation) |

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
- **Épreuves anticipées en fin de 1ère : français (écrit coef 5 + oral coef 5) et mathématiques (écrit 2 h, coef 2)**. L'épreuve anticipée de maths existe depuis la session 2027 (décret du 10-6-2025, note de service du 11-9-2026) : elle est obligatoire pour tous, porte sur la spé maths ou, à défaut, sur les maths intégrées à l'ES, et la calculatrice y est interdite.

Barème : 40 % contrôle continu, 60 % épreuves finales ; chaque spécialité vaut 16 (deux spés = 32). Tableau complet et à jour dans `references/epreuves-bac.md` — c'est lui qui fait foi, pas un souvenir de la réforme 2019.

## Workflow

1. **Cadrer** : niveau, discipline, spécialité ou tronc commun, année scolaire, objectif (comprendre un chapitre, fiche de révision, série d'exos, devoir surveillé, aide à l'orientation).
2. **Récupérer le texte officiel** : `scripts/fetch_programmes.sh` télécharge les PDF dans le dossier courant, ou piocher les URLs dans `references/sources-officielles.md`.
3. **Lire la bonne colonne** : contenus = quoi, capacités attendues = jusqu'où. Ne pas dépasser.
4. **Produire** en nommant la capacité visée et en signalant les approfondissements.
5. **Vérifier** : chaque notion de la fiche/exo se retrouve dans le PDF. Si une notion n'y est pas, elle est hors programme pour ce niveau — le dire.

## Matières couvertes

Une fiche par matière dans `references/matieres/`, chacune avec la version du programme en vigueur, les parties du BO et les épreuves. Index synthétique : `references/programmes-1ere-generale-2026.md`.

| Spécialité (13) | Fiche | Tronc commun | Fiche |
|---|---|---|---|
| Mathématiques | `maths.md` | Français | `francais.md` |
| Physique-chimie | `physique-chimie.md` | Histoire-géo + EMC | `histoire-geo-emc.md` |
| SVT | `svt.md` | Langues vivantes | `langues-vivantes.md` |
| NSI | `nsi.md` | EPS | `eps.md` |
| SES | `ses.md` | Enseignement scientifique | `enseignement-scientifique.md` |
| HGGSP | `hggsp.md` | | |
| HLP | `hlp.md` | **Options de Terminale** | |
| LLCER | `llcer.md` | Maths expertes, maths complémentaires, droit et grands enjeux du monde contemporain | — |
| LLCA (latin/grec) | `llca.md` | | |
| Sciences de l'ingénieur | `si.md` | | |
| Arts (6 options) | `arts.md` | | |
| EPPCS | `eppcs.md` | | |
| Biologie-écologie | `biologie-ecologie.md` | | |

Attention à ne pas appeler « spécialité » ce qui est une option de Terminale : maths expertes, maths complémentaires (AMC) et droit et grands enjeux du monde contemporain n'existent pas en 1ère.

## Déploiement : un profil par matière

Le dépôt qui porte ce skill contient aussi `install.sh` (Linux/macOS) et `install.ps1` (Windows) : ils installent le skill et créent un profil Hermes par matière (`lycee-maths`, `lycee-svt`, `lycee-francais`…), chacun avec son SOUL borné à sa discipline et sa mémoire amorcée. Lancer une matière : `hermes -p lycee-maths chat`.

Pourquoi un profil par matière plutôt qu'un seul agent : la mémoire d'un profil reste propre à la discipline (difficultés récurrentes en maths ne polluent pas le français), et le SOUL peut imposer un ton et un périmètre adaptés. Le skill lui-même est identique dans tous les profils — il n'est chargé qu'à la demande.


## Ressources libres utilisables

Voir `references/ressources-libres.md` (Bacomathiques, MathALÉA, NSI-Clemenceau) avec leurs licences — un cours de prof déposé sur GitHub reste protégé : citation, pas recopie.

## Pièges

- **Croire que le bac est encore celui de 2019.** Depuis la session 2027 il y a une épreuve anticipée de maths (coef 2) et le grand oral est passé à 8. Voir `references/epreuves-bac.md`.
- **Écrire « les deux spécialités valent 16 au total »** : c'est 16 *chacune*, donc 32 points.
- Confondre **contenus** et **capacités attendues** : c'est l'erreur qui produit des exercices hors programme.
- Confondre **spécialité** et **enseignement scientifique** : deux programmes distincts en 1ère.
- Utiliser un manuel ou un site d'avant 2026 pour les maths de 1ère.
- « Programme de 1ère » sans préciser la voie : la voie techno (STMG, STI2D, ST2S…) a ses propres programmes.
- Le programme de français de 1ère liste des **œuvres** qui changent chaque année : ne jamais les citer de mémoire, vérifier sur éduscol.
