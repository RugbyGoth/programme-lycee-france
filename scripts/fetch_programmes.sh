#!/usr/bin/env bash
# Télécharge les programmes officiels du lycée (1ère générale) en PDF.
# Usage : ./fetch_programmes.sh [dossier]   (défaut : ./programmes-lycee)
set -euo pipefail

DEST="${1:-./programmes-lycee}"
mkdir -p "$DEST"
cd "$DEST"

GOUV="https://www.education.gouv.fr/sites/default/files/document"
EDUSCOL="https://eduscol.education.gouv.fr/sites/default/files/document"

fetch() { # nom_fichier url
  if [ -s "$1" ]; then echo "= $1 (déjà présent)"; return; fi
  echo "+ $1"
  curl -fsSL --max-time 60 -o "$1" "$2" || { echo "  ! échec : $2"; rm -f "$1"; }
}

# Maths 1ère spé — programme 2026 (rentrée 2026-2027)
fetch "maths-1ere-spe-2026.pdf" \
  "$GOUV/Annexe%20%E2%80%93%20Programme%20d%26%23039%3Benseignement%20de%20sp%C3%A9cialit%C3%A9%20de%20math%C3%A9matiques%20de%20la%20classe%20de%20premi%C3%A8re%20de%20la%20voie%20g%C3%A9n%C3%A9rale-515408.pdf"

# Maths intégrées à l'enseignement scientifique, 1ère (2026)
fetch "maths-integrees-es-1ere-2026.pdf" \
  "$GOUV/Annexe%20%E2%80%93%20Programme%20de%20math%C3%A9matiques%20int%C3%A9gr%C3%A9%20%C3%A0%20l%26%23039%3Benseignement%20scientifique%20en%20classe%20de%20premi%C3%A8re%20g%C3%A9n%C3%A9rale-515405.pdf"

# Physique-chimie 1ère spé (BO spécial n°1 du 22/01/2019)
fetch "physique-chimie-1ere-spe-2019.pdf" "$EDUSCOL/spe635annexe1063432pdf-82266.pdf"

# SVT 1ère spé (2019)
fetch "svt-1ere-spe-2019.pdf" "$EDUSCOL/spe648annexe1063542pdf-82878.pdf"

# NSI 1ère (2019)
fetch "nsi-1ere-2019.pdf" "$EDUSCOL/spe633annexe1063268pdf-89499.pdf"

# Enseignement scientifique 1ère (BO du 22/06/2023)
fetch "enseignement-scientifique-1ere-2023.pdf" \
  "$GOUV/Annexe%20%E2%80%93%20Programme%20d%E2%80%99enseignement%20scientifique%20de%20%20premi%C3%A8re%20g%C3%A9n%C3%A9rale-365055.pdf"

echo
echo "PDF dans : $(pwd)"
ls -lh *.pdf 2>/dev/null | awk '{print "  " $9 " (" $5 ")"}'
echo
echo "Texte extractible avec : pdftotext fichier.pdf - | less   (paquet poppler-utils)"
