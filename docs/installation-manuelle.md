# Installation manuelle (sans script)

À utiliser si la commande `hermes` n'est pas disponible sur la machine (Hermes Desktop seul, par exemple). Compter 10 à 15 minutes. Aucune connaissance technique requise, mais il faut savoir ouvrir un dossier de fichiers.

Les libellés exacts de l'interface desktop peuvent varier d'une version à l'autre : ce qui compte est le **rôle** de chaque écran, décrit ici.

---

## Étape 1 — récupérer les fichiers

1. Ouvrir https://github.com/RugbyGoth/programme-lycee-france
2. Bouton vert **Code** → **Download ZIP**
3. Dézipper l'archive : on obtient un dossier `programme-lycee-france-main` contenant `skill/`, `install.sh`, `subjects.txt`…

## Étape 2 — trouver le dossier de données Hermes

C'est le dossier qui contient un fichier `config.yaml`, un dossier `skills` et un dossier `profiles`.

| Système | Emplacement le plus probable |
|---|---|
| Windows | `%USERPROFILE%\.hermes` (soit `C:\Users\<nom>\.hermes`) |
| macOS | `~/.hermes` (menu Finder → Aller → Aller au dossier… → `~/.hermes`) |
| Linux | `~/.hermes` ou `~/.config/hermes` |

Si l'un de ces dossiers n'existe pas, cherche un dossier nommé `hermes` dans le dossier de données de l'application (sur Windows : `%LOCALAPPDATA%` ou `%APPDATA%`).

> Astuce : dans les réglages de Hermes, il existe en général une ligne indiquant le répertoire de données (« data directory » / « Path »). C'est le bon dossier.

## Étape 3 — installer le skill

1. Dans `<données Hermes>\skills\`, créer un dossier nommé **`programmes-lycee-france`**
2. Copier dedans **tout le contenu** de `programme-lycee-france-main/skill/` (SKILL.md, le dossier `references`, le dossier `scripts`)

Résultat attendu :

```
<données Hermes>\skills\programmes-lycee-france\SKILL.md
<données Hermes>\skills\programmes-lycee-france\references\matieres\maths.md
...
```

Relancer Hermes. Le skill doit apparaître dans la liste des skills disponibles.

## Étape 4 — créer les profils

Le but : un profil par matière. Dans l'interface, cherche la liste des profils et l'action « créer un profil » (ou « nouveau profil »). Crée-les un par un, avec ces noms exacts :

```
lycee  lycee-maths  lycee-physique-chimie  lycee-svt  lycee-nsi  lycee-ses
lycee-hggsp  lycee-hlp  lycee-llcer  lycee-llca  lycee-si  lycee-arts
lycee-eppcs  lycee-biologie-ecologie  lycee-francais  lycee-histoire-geo
lycee-langues  lycee-eps  lycee-enseignement-scientifique
```

Si l'interface ne propose pas la création de profil, l'alternative est de dupliquer le profil existant (option « cloner » / « dupliquer ») puis de le renommer.

Chaque profil doit avoir **sa propre clé API de modèle** : soit tu la saisis une fois par profil, soit tu copies le fichier `.env` du profil principal dans le dossier du nouveau profil.

## Étape 5 — écrire la personnalité du profil (SOUL.md)

Chaque profil a un dossier `profiles\<nom du profil>\` contenant un fichier `SOUL.md`.

**Ne pas l'effacer** : il commence par un préambule Hermes qu'il faut garder. Ajoute à la fin du fichier le bloc ci-dessous, en remplaçant `MATIÈRE`, `FICHE` et le titre :

```markdown
---

## Domaine : MATIÈRE — 1ère générale

Tu es le professeur attitré de **MATIÈRE** pour un élève de Première générale (année scolaire 2026-2027).

Fiche de référence à charger en premier : `references/matieres/FICHE` du skill `programmes-lycee-france`
(charge le skill avec skill_view, puis lis cette fiche avant de répondre sur le fond).

### Méthode

- Vérifie toujours que la notion est **au programme de 1ère** avant de l'enseigner ; la fiche de
  référence dit quelle version du programme est en vigueur. Si la notion n'y est pas : dis-le.
- Explique la méthode, fais faire un pas à l'élève, corrige ensuite. Ne livre pas la correction
  intégrale d'un exercice du premier coup, sauf demande explicite.
- Style lycée : phrases courtes, un exemple concret avant la formule, pas de jargon non défini.
- Un exercice proposé s'adosse à une capacité attendue du programme ; signale ce qui relève d'un
  approfondissement facultatif.

### Périmètre

- Tu couvres : cours, fiches de révision, exercices, devoirs surveillés, préparation des épreuves,
  méthode de travail pour cette matière.
- Hors matière → une ligne : « pour ça, demande au profil lycee-<matière> » (ou `lycee` pour
  l'orientation générale).
- Pas de diagnostic d'orientation définitif, pas de conseil médical.

### Mémoire

- Note ce qui aide vraiment : chapitres déjà vus, difficultés récurrentes, formats d'exercices du
  prof, dates de contrôles. Ne recopie pas le contenu des cours.
```

Le fichier `subjects.txt` du dépôt donne, ligne par ligne, le nom du profil, le libellé de la matière et la fiche correspondante.

## Étape 6 — amorcer la mémoire (facultatif mais utile)

Dans `profiles\<nom du profil>\memories\MEMORY.md`, écrire :

```
NIVEAU : 1ère générale, année scolaire 2026-2027.
§
MATIÈRE : <matière> — fiche references/matieres/<fiche>.md du skill programmes-lycee-france.
```

Puis une ligne par fait utile au fil de l'année (chapitres vus, contrôles à venir, difficultés).

## Vérification

Ouvre le profil `lycee-maths` et demande :

> Le produit scalaire est-il au programme de 1ère cette année ?

Réponse attendue : oui, depuis le programme 2026 (BO du 2 avril 2026), alors qu'il était en Terminale dans le programme précédent. Si le profil répond « non, c'est du programme de Terminale », c'est qu'il n'a pas lu la fiche : vérifie l'étape 3 et le nom de la fiche à l'étape 5.
