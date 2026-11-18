# lycee-1ere — un professeur Hermes par matière

Kit pour faire tourner un agent Hermes comme **professeur particulier de Première générale** : un skill qui connaît les programmes officiels français, et un profil Hermes par matière (maths, PC, SVT, NSI, SES, HGGSP, HLP, LLCER, LLCA, SI, arts, EPPCS, biologie-écologie, français, histoire-géo, langues, EPS, enseignement scientifique).

Chaque profil a sa propre mémoire : les difficultés récurrentes en maths ne polluent pas le cours de français.

## Ce que ça donne

```bash
hermes -p lycee-maths chat -q "explique la dérivation, avec un exemple puis un exercice"
hermes -p lycee-francais chat -q "prépare-moi l'oral sur l'objet d'étude le théâtre"
hermes -p lycee chat -q "quelles spé garder pour une prépa BCPST ?"
```

Et dans Hermes Desktop : choisir le profil `lycee-maths` dans la liste, puis discuter normalement.

## Le point qui compte

Les programmes de lycée ne sont pas tous au même millésime, et **les maths de 1ère ont changé à la rentrée 2026-2027** (BO n° 14 du 2 avril 2026) :

- le **produit scalaire** et la **géométrie repérée du cercle** sont passés en 1ère ;
- « Automatismes » est devenu une partie du programme ;
- toute progression de 1ère antérieure à 2026 est fausse sur la fin d'année.

Physique-chimie, SVT et NSI restent sur les programmes de 2019 ; l'enseignement scientifique sur celui de 2023.

## Ce qu'il y a dedans

```
skill/                          le skill « programmes-lycee-france »
  SKILL.md                      quand l'utiliser, méthode, millésimes des programmes
  references/matieres/*.md      une fiche par matière (programme en vigueur, thèmes, épreuves)
  references/sources-officielles.md   URL des PDF officiels + comment vérifier les versions
  references/ressources-libres.md     dépôts GitHub utilisables et leurs licences
  scripts/fetch_programmes.sh   télécharge les PDF du BO
install.sh / install.ps1        installation en une commande
subjects.txt                    liste des profils créés
docs/installation-manuelle.md   la même chose à la main, si le script ne passe pas
```

## Prérequis

1. **Hermes installé** (Desktop, ou CLI) : https://hermes-agent.nousresearch.com/docs
2. **Une clé API de modèle configurée une fois** dans le profil par défaut. L'installeur clone ce profil, donc les nouveaux profils héritent de la clé.
3. `git` (pour récupérer le dépôt) ; sur Windows, fourni avec Git for Windows.

## Installation

### Voie A — le script (2 minutes)

```bash
git clone https://github.com/RugbyGoth/lycee-1ere.git
cd lycee-1ere

# Linux / macOS
./install.sh

# Windows (PowerShell)
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

Le script :
- installe le skill dans le profil par défaut ;
- crée un profil par matière (`lycee-maths`, `lycee-svt`…) en clonant ta config et ta clé API ;
- écrit le SOUL de chaque profil (rôle, périmètre, méthode pédagogique) ;
- amorce la mémoire de chaque profil.

Il est **idempotent** : relancé, il met à jour le skill et laisse les profils existants tranquilles. Options : `--dry-run` (montre sans agir), `--skill-only` (juste le skill).

### Voie B — à la main

Si la commande `hermes` n'existe pas sur la machine (Desktop seul), suis `docs/installation-manuelle.md` : 6 étapes, aucune compétence technique requise.

## Les matières

| Profil | Matière | Fiche |
|---|---|---|
| `lycee-maths` | Mathématiques (spé) | `maths.md` |
| `lycee-physique-chimie` | Physique-chimie (spé) | `physique-chimie.md` |
| `lycee-svt` | SVT (spé) | `svt.md` |
| `lycee-nsi` | NSI (spé) | `nsi.md` |
| `lycee-ses` | SES (spé) | `ses.md` |
| `lycee-hggsp` | HGGSP (spé) | `hggsp.md` |
| `lycee-hlp` | HLP (spé) | `hlp.md` |
| `lycee-llcer` | LLCER (spé) | `llcer.md` |
| `lycee-llca` | LLCA latin/grec (spé) | `llca.md` |
| `lycee-si` | Sciences de l'ingénieur (spé) | `si.md` |
| `lycee-arts` | Arts (spé, 6 options) | `arts.md` |
| `lycee-eppcs` | EPPCS (spé) | `eppcs.md` |
| `lycee-biologie-ecologie` | Biologie-écologie (spé, lycée agricole) | `biologie-ecologie.md` |
| `lycee-francais` | Français (tronc commun, épreuves anticipées) | `francais.md` |
| `lycee-histoire-geo` | Histoire-géo + EMC | `histoire-geo-emc.md` |
| `lycee-langues` | Langues vivantes (LVA/LVB, LVC) | `langues-vivantes.md` |
| `lycee-eps` | EPS | `eps.md` |
| `lycee-enseignement-scientifique` | Enseignement scientifique | `enseignement-scientifique.md` |
| `lycee` | Tuteur général / orientation | — |

## Utilisation des PDF officiels

```bash
chmod +x skill/scripts/fetch_programmes.sh
./skill/scripts/fetch_programmes.sh ~/programmes-lycee
pdftotext ~/programmes-lycee/maths-1ere-spe-2026.pdf - | less
```

Nécessite `curl` et, pour lire le texte, `poppler-utils`.

## Mise à jour

```bash
git pull && ./install.sh
```

Le script réinstalle le skill partout et **ne touche pas** aux profils déjà créés (ni à leur mémoire).

## Désinstallation

Retirer les profils, un par un, depuis l'interface Hermes ou :

```bash
hermes profile delete lycee-maths
```

Puis supprimer le dossier `skills/programmes-lycee-france` du répertoire de données Hermes.

## Limites, dites franchement

- Les fiches sont établies sur les **PDF officiels au 18 novembre 2026**. Les maths de 1ère ont changé à la rentrée 2026 (BO du 2 avril 2026) ; les autres disciplines sont sur les programmes 2019, l'enseignement scientifique sur celui de 2023. Si un BO paraît, relancer le script de téléchargement et comparer.
- Certaines spécialités sont moins détaillées que d'autres (biologie-écologie, arts, EPPCS) : la fiche le dit quand une information n'a pas pu être vérifiée. Mieux vaut une fiche honnête qu'une fiche inventée.
- Les **œuvres au programme de français** changent chaque année : la fiche renvoie à éduscol, elle ne fige pas de liste.
- Aucun contenu de manuel ou de cours de professeur n'est recopié. Les ressources tierces citées (Bacomathiques, MathALÉA, NSI Clemenceau) gardent leurs licences, décrites dans `skill/references/ressources-libres.md`.
- Les PDF du BO ne sont pas dans le dépôt : le script les télécharge depuis education.gouv.fr.

## Licence

MIT pour le texte du skill et les scripts (voir `LICENSE`). Les documents officiels restent la propriété de l'État, réutilisables librement.
