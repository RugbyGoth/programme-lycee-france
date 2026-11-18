# programmes-lycee-france

Skill Hermes pour travailler sur les **programmes du lycée français** (voie générale et technologique) : expliquer un chapitre, produire une fiche de révision, une série d'exercices ou un devoir surveillé, vérifier qu'une notion est bien au programme.

Écrit pour la 1ère générale, profil scientifique (Maths / Physique-chimie / SVT, NSI en option), mais couvre aussi la Terminale et le tronc commun.

## Le point qui compte

Les programmes de lycée ne sont pas tous au même millésime, et **les maths de 1ère ont changé à la rentrée 2026-2027** (BO n° 14 du 2 avril 2026) :

- le **produit scalaire** et la **géométrie repérée du cercle** sont passés en 1ère ;
- « Automatismes » est devenu une partie du programme ;
- toute progression de 1ère antérieure à 2026 est fausse sur la fin d'année.

Physique-chimie, SVT et NSI restent sur les programmes de 2019 ; l'enseignement scientifique sur celui de 2023.

## Contenu

```
SKILL.md                                     procédure, millésimes, pièges
references/programmes-1ere-generale-2026.md  structure réelle des programmes, matière par matière
references/sources-officielles.md            URL des PDF officiels + comment vérifier la version en vigueur
references/ressources-libres.md              dépôts GitHub utilisables, avec leurs licences
scripts/fetch_programmes.sh                  télécharge les 6 PDF officiels
```

## Utilisation du script

```bash
chmod +x scripts/fetch_programmes.sh
./scripts/fetch_programmes.sh ~/programmes-lycee
pdftotext ~/programmes-lycee/maths-1ere-spe-2026.pdf - | less
```

Nécessite `curl` et, pour lire le texte, `poppler-utils`.

## Licence

Texte du skill sous MIT (voir `LICENSE`). Les PDF officiels ne sont pas redistribués ici : le script les télécharge depuis education.gouv.fr. Les ressources tierces citées (Bacomathiques, MathALÉA, NSI Clemenceau) gardent leurs licences respectives — voir `references/ressources-libres.md`.
