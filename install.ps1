# Installe le skill « programmes-lycee-france » et un profil Hermes par matière
# de 1ère générale, sur Windows. Idempotent : relançable sans casser l'existant.
#
#   powershell -ExecutionPolicy Bypass -File .\install.ps1
#   powershell -ExecutionPolicy Bypass -File .\install.ps1 -SkillOnly
#   powershell -ExecutionPolicy Bypass -File .\install.ps1 -DryRun
param(
    [switch]$SkillOnly,
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'
$RepoDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SkillSrc = Join-Path $RepoDir 'skill'
$SkillName = 'programmes-lycee-france'
$Utf8 = New-Object System.Text.UTF8Encoding($false)

function Say($m) { Write-Host $m }

# ---------------------------------------------------------------- 1. le CLI
$hermes = Get-Command hermes -ErrorAction SilentlyContinue
if (-not $hermes) {
    Say "X La commande 'hermes' est introuvable dans le PATH."
    Say ""
    Say "  Cette installation passe par le CLI Hermes (le moteur des profils)."
    Say "  Installe Hermes d'abord : https://hermes-agent.nousresearch.com/docs"
    Say "  Ou suis la section « Installation manuelle » du README."
    exit 1
}
Say "OK hermes : $($hermes.Source)"

# ------------------------------------------------------- 2. répertoire données
$data = $env:HERMES_DATA_DIR
if (-not $data) {
    $line = (& hermes profile show default 2>$null | Select-String -Pattern '^Path:\s*(.+)$' | Select-Object -First 1)
    if ($line) { $data = $line.Matches[0].Groups[1].Value.Trim() }
}
if (-not $data) {
    foreach ($c in @("$env:USERPROFILE\.hermes", "$env:LOCALAPPDATA\hermes", "$env:APPDATA\hermes")) {
        if (Test-Path $c) { $data = $c; break }
    }
}
if (-not $data -or -not (Test-Path $data)) {
    Say "X Impossible de localiser le répertoire de données Hermes."
    Say "  Lance : hermes profile show default  puis reporte la ligne 'Path:'"
    exit 1
}
Say "OK donnees Hermes : $data"

$SkillsDir   = Join-Path $data 'skills'
$ProfilesDir = Join-Path $data 'profiles'

# ------------------------------------------------------------- 3. le skill
Say ""
Say "-- Skill $SkillName"
$target = Join-Path $SkillsDir $SkillName
if (-not $DryRun) {
    New-Item -ItemType Directory -Force -Path $SkillsDir | Out-Null
    if (Test-Path $target) { Remove-Item -Recurse -Force $target }
    Copy-Item -Recurse -Force $SkillSrc $target
}
Say "   -> $target"

if ($SkillOnly) { Say ""; Say "Fait (skill seul)."; exit 0 }

# ----------------------------------------------------------- 4. les profils
Say ""
Say "-- Profils par matiere"
$created = 0; $skipped = 0; $failed = 0
$rows = Get-Content (Join-Path $RepoDir 'subjects.txt') -Encoding UTF8 |
        Where-Object { $_ -and -not $_.StartsWith('#') }

foreach ($row in $rows) {
    $f = $row -split "`t"
    if ($f.Count -lt 4) { continue }
    $slug = $f[0]; $label = $f[1]; $fiche = $f[2]; $desc = $f[3]
    $p = Join-Path $ProfilesDir $slug

    if (Test-Path $p) { Say "   = $slug (deja present, laisse tel quel)"; $skipped++; continue }
    if ($DryRun) { Say "   [dry-run] creer $slug - $label"; $created++; continue }

    & hermes profile create $slug --clone --no-alias --description $desc 2>&1 | Out-Null
    if (-not (Test-Path $p)) { Say "   X $slug - echec de creation"; $failed++; continue }

    New-Item -ItemType Directory -Force -Path (Join-Path $p 'skills'),
        (Join-Path $p 'memories'), (Join-Path $p 'home\references') | Out-Null

    $psk = Join-Path $p "skills\$SkillName"
    if (-not (Test-Path $psk)) { Copy-Item -Recurse -Force $SkillSrc $psk }

    $soul = @"

---

## Domaine : $label — 1ère générale

Tu es le professeur attitré de **$label** pour un élève de Première générale (année scolaire 2026-2027).

"@
    if ($fiche -ne '—') {
        $soul += "Fiche de référence à charger en premier : ``references/matieres/$fiche`` du skill ``$SkillName`` (charge le skill avec skill_view, puis lis cette fiche avant de répondre sur le fond).`n`n"
    } else {
        $soul += "Tu es le tuteur général : tu réponds aux questions de méthode et d'orientation, et tu renvoies vers le profil matière concerné pour le contenu.`n`n"
    }
    $soul += @"
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
- Hors matière → une ligne : « pour ça, demande au profil ``lycee-<matière>`` » (ou ``lycee`` pour
  l'orientation générale).
- Pas de diagnostic d'orientation définitif, pas de conseil médical.

### Mémoire

- Note ce qui aide vraiment : chapitres déjà vus, difficultés récurrentes, formats d'exercices du
  prof, dates de contrôles. Ne recopie pas le contenu des cours.

"@
    [System.IO.File]::AppendAllText((Join-Path $p 'SOUL.md'), $soul, $Utf8)

    $mem = Join-Path $p 'memories\MEMORY.md'
    if (-not (Test-Path $mem) -or (Get-Item $mem).Length -eq 0) {
        $txt = "NIVEAU : 1ère générale, année scolaire 2026-2027.`n§`nMATIÈRE : $label — fiche references/matieres/$fiche du skill $SkillName.`n"
        [System.IO.File]::WriteAllText($mem, $txt, $Utf8)
    }

    Say "   + $slug - $label"
    $created++
}

# ------------------------------------------------------------ 5. récapitulatif
Say ""
Say "-----------------------------------------------"
Say "skill   : $target"
Say "profils : $created cree(s), $skipped deja present(s), $failed echec(s)"
Say ""
if (-not $DryRun) {
    Say "Lancer un profil :"
    Say '  hermes -p lycee-maths chat'
    Say '  hermes -p lycee-maths chat -q "explique la derivation avec un exemple"'
    Say ""
    Say "Verifier : hermes profile list"
}
if ($failed -gt 0) { exit 1 }
