# Ressources libres pour le lycée (état novembre 2026)

Recherche faite via l'API GitHub publique. Aucun dépôt ne couvre tout le lycée : c'est du matière par matière, souvent un site de prof.

## Recommandées

### Bacomathiques — maths 1ère et Terminale
- Dépôt : https://github.com/Skyost/Bacomathiques (34 ★, dernier push 13/11/2026)
- Site : https://bacomathiqu.es/cours/
- Contenu : cours LaTeX conformes aux programmes officiels, annales du bac, application mobile, tout gratuit sans compte. Contenu source : `content/latex/lessons/premiere/` (second degré, dérivation, exponentielle, trigonométrie, géométrie repérée, probabilités, suites, algorithmique).
- **Licence** : reproduction interdite sauf usage pédagogique et non commercial, avec citation explicite de Bacomathiques. Les annales appartiennent à maths-france.fr. Donc : lecture, impression personnelle, citation — pas de republication.
- Limite : la progression des cours suit l'ancien programme (pas la réforme 2026) → recouper avec le BO 2026.

### MathALÉA (CoopMaths) — générateur d'exercices
- Dépôt : https://github.com/mathalea/mathalea (24 ★, AGPL-3.0)
- Site : https://coopmaths.fr/mathalea.html
- Contenu : exercices de maths à données aléatoires, avec corrigés, étiquetés par niveau — les exercices de 1ère sont dans `src/js/exercices/1e/` (préfixes 1AN, 1E, 1F, 1G…). Peut tourner en local.
- **Licence** : AGPL-3.0 — réutilisation et modification autorisées, mais tout service dérivé doit rester sous AGPL. Vérifier l'étiquetage des exercices : il suit le programme d'origine du dépôt.

### NSI Clemenceau — NSI 1ère complète
- Dépôt : https://github.com/NSI-Clemenceau/NSI_1ere (5 ★)
- Contenu : les 7 rubriques du programme NSI 1ère, cours, TP, projets, le BO en PDF, un oral de NSI.
- Utile comme trame de progression ; vérifier la licence avant réutilisation (fichier LICENSE.md du dépôt).

## Correctes mais à vérifier au cas par cas

- https://github.com/cours-maths-lycee/cours-maths-lycee.github.io — 1ère spé maths, 16 chapitres (second degré, dérivation, suites, trigonométrie, probabilités conditionnelles, produit scalaire…). Dépôt récent, pas de licence claire.
- https://github.com/z-lechevalier/physique-chimie-lycee — physique-chimie seconde et 1ère spé : vidéos de classe inversée, quiz, documents « conçus d'après les approches officielles ». Seule ressource PC un peu structurée trouvée.
- https://github.com/raoulhatterer/ppc — site MkDocs de spé PC en 1ère.
- https://github.com/Asolectine/1ereSPE — scripts Python des TP de PC 1ère spé (2021).

## Ce qui n'existe pas

- Aucun dépôt ne contient les programmes officiels du lycée en données structurées (JSON/YAML). `jeremyjdo/vale.edu` (MIT, 5 604 notions) s'arrête à la 3e.
- Pas de dépôt sérieux couvrant la physique-chimie de 1ère comme Bacomathiques couvre les maths.

## Règle d'usage

Un dépôt GitHub de prof n'est pas un manuel libre : sans licence explicite, tous droits réservés (code visible ≠ libre). Citer la source, ne pas recopier dans un document publié, et privilégier ce qui est sous AGPL/MIT/CC.
