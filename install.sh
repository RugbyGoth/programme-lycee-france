#!/usr/bin/env bash
# Installe le skill « programmes-lycee-france » et un profil Hermes par matière
# de 1ère générale. Idempotent : relançable sans casser l'existant.
#
# Usage :
#   ./install.sh              installe tout
#   ./install.sh --skill-only installe seulement le skill
#   ./install.sh --dry-run    montre ce qui serait fait
set -uo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_SRC="$REPO_DIR/skill"
SKILL_NAME="programmes-lycee-france"
DRY=0
SKILL_ONLY=0
PRESET="subjects.txt"
while [ $# -gt 0 ]; do
  case "$1" in
    --dry-run) DRY=1 ;;
    --skill-only) SKILL_ONLY=1 ;;
    --preset) shift; case "${1:-}" in scientifique) PRESET="subjects-scientifique.txt" ;; *) PRESET="$1" ;; esac ;;
    -h|--help) sed -n '2,9p' "$0"; exit 0 ;;
    *) echo "option inconnue : $1"; exit 2 ;;
  esac
  shift
done

say() { printf '%s\n' "$*"; }
run() { if [ "$DRY" = 1 ]; then say "  [dry-run] $*"; else "$@"; fi; }

# ---------------------------------------------------------------- 1. le CLI
if ! command -v hermes >/dev/null 2>&1; then
  say "✗ La commande 'hermes' est introuvable."
  say ""
  say "  Cette installation passe par le CLI Hermes (le moteur des profils)."
  say "  Installe-le d'abord : https://hermes-agent.nousresearch.com/docs"
  say "  Puis relance : ./install.sh"
  say ""
  say "  Si tu utilises Hermes Desktop sans CLI, suis la section"
  say "  « Installation manuelle » du README (6 étapes, ~10 minutes)."
  exit 1
fi
say "✓ hermes : $(command -v hermes)"

# ------------------------------------------------------- 2. répertoire données
DATA="${HERMES_DATA_DIR:-}"
[ -n "$DATA" ] || DATA="$(hermes profile show default 2>/dev/null | sed -n 's/^Path:[[:space:]]*//p' | head -1)"
if [ -z "${DATA:-}" ] || [ ! -d "$DATA" ]; then
  for c in "${HERMES_HOME:-}" "$HOME/.hermes" "$HOME/.config/hermes" /opt/data; do
    [ -n "$c" ] && [ -d "$c" ] && DATA="$c" && break
  done
fi
if [ -z "${DATA:-}" ] || [ ! -d "$DATA" ]; then
  say "✗ Impossible de localiser le répertoire de données Hermes."
  say "  Lance : hermes profile show default   puis reporte la ligne 'Path:'"
  exit 1
fi
say "✓ données Hermes : $DATA"

SKILLS_DIR="$DATA/skills"
PROFILES_DIR="$DATA/profiles"

# ------------------------------------------------------------- 3. le skill
say ""
say "— Skill $SKILL_NAME"
run mkdir -p "$SKILLS_DIR"
if [ -d "$SKILLS_DIR/$SKILL_NAME" ]; then
  say "  mise à jour de l'installation existante"
  run rm -rf "$SKILLS_DIR/$SKILL_NAME"
fi
run cp -R "$SKILL_SRC" "$SKILLS_DIR/$SKILL_NAME"
run chmod +x "$SKILLS_DIR/$SKILL_NAME/scripts/fetch_programmes.sh" 2>/dev/null
say "  → $SKILLS_DIR/$SKILL_NAME"

if [ "$SKILL_ONLY" = 1 ]; then
  say ""
  say "Fait. Le skill est disponible ; aucun profil créé (--skill-only)."
  exit 0
fi

# ----------------------------------------------------------- 4. les profils
say ""
say "— Profils par matière"
CREATED=0; SKIPPED=0; FAILED=0
while IFS=$'\t' read -r slug label fiche desc; do
  case "$slug" in ''|\#*) continue ;; esac

  if [ -d "$PROFILES_DIR/$slug" ]; then
    say "  = $slug (déjà présent, laissé tel quel)"
    SKIPPED=$((SKIPPED+1))
    continue
  fi

  if [ "$DRY" = 1 ]; then
    say "  [dry-run] créer $slug — $label"
    CREATED=$((CREATED+1))
    continue
  fi

  # --clone : reprend config.yaml, .env (clés API) et skills du profil actif.
  if timeout 180 hermes profile create "$slug" --clone --no-alias \
       --description "$desc" >/dev/null 2>&1 || [ -d "$PROFILES_DIR/$slug" ]; then
    P="$PROFILES_DIR/$slug"
    mkdir -p "$P/skills" "$P/memories" "$P/home/references"

    # le skill doit être présent dans le profil (clone l'a copié si déjà installé)
    if [ ! -d "$P/skills/$SKILL_NAME" ]; then
      cp -R "$SKILL_SRC" "$P/skills/$SKILL_NAME"
    fi

    # personnalité : on garde le préambule Hermes du SOUL cloné, on ajoute le domaine
    {
      printf '\n---\n\n'
      printf '## Domaine : %s — 1ère générale\n\n' "$label"
      printf 'Tu es le professeur attitré de **%s** pour un élève de Première générale (année scolaire 2026-2027).\n\n' "$label"
      if [ "$fiche" != "—" ]; then
        printf 'Fiche de référence à charger en premier : `references/matieres/%s` du skill `%s`\n' "$fiche" "$SKILL_NAME"
        printf '(charge le skill avec skill_view, puis lis cette fiche avant de répondre sur le fond).\n\n'
      else
        printf 'Tu es le tuteur général : tu réponds aux questions de méthode et d'"'"'orientation, et tu\nrenvoies vers le profil matière concerné pour le contenu.\n\n'
      fi
      cat <<'EOSOUL'
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
- Hors matière → une ligne : « pour ça, demande au profil `lycee-<matière>` » (ou renvoie au profil
  `lycee` pour l'orientation générale).
- Pas de diagnostic d'orientation définitif, pas de conseil médical.

### Mémoire

- Note ce qui aide vraiment : chapitres déjà vus, difficultés récurrentes, formats d'exercices du
  prof, dates de contrôles. Ne recopie pas le contenu des cours.
EOSOUL
    } >> "$P/SOUL.md"

    # amorce mémoire
    if [ ! -s "$P/memories/MEMORY.md" ]; then
      printf 'NIVEAU : 1ère générale, année scolaire 2026-2027.\n§\nMATIÈRE : %s — fiche references/matieres/%s du skill %s.\n' \
        "$label" "$fiche" "$SKILL_NAME" > "$P/memories/MEMORY.md"
    fi

    say "  + $slug — $label"
    CREATED=$((CREATED+1))
  else
    say "  ✗ $slug — échec de création (voir : hermes profile list)"
    FAILED=$((FAILED+1))
  fi
done < "$REPO_DIR/$PRESET"

# ------------------------------------------------------------ 5. récapitulatif
say ""
say "———————————————————————————————"
say "skill     : $SKILLS_DIR/$SKILL_NAME"
say "profils   : $CREATED créé(s), $SKIPPED déjà présent(s), $FAILED échec(s)"
say ""
if [ "$DRY" = 0 ]; then
  say "Lancer un profil :"
  say "  hermes -p lycee-maths chat              (session interactive)"
  say "  hermes -p lycee-maths chat -q \"explique la dérivation avec un exemple\""
  say ""
  say "Vérifier : hermes profile list"
  say "Mettre à jour plus tard : ./install.sh   (relit ce dépôt, ne touche pas aux profils existants)"
fi
[ "$FAILED" = 0 ]
