#!/bin/sh
# Génère le PDF d'assemblage (top + bottom) avec KiCad 10.
set -e
cd "$(dirname "$0")"

# KiCad 10 (le kicad-cli système est en v9 et ne lit pas les fichiers v10)
KICAD_CLI="${KICAD_CLI:-$(realpath ../../../tools/konnect/kicad-cli)}"
PCB=elec_grabette_io.kicad_pcb
OUT=production/ASE01215-A1_elec_grabette_io_ASY.pdf

# KiCad 10 : --mode-single pour que -o soit un fichier (et non un dossier)
"$KICAD_CLI" pcb export pdf --mode-single --layers "User.1,F.Courtyard,User.Drawings,Edge.Cuts" --include-border-title -o assemblage_top.pdf "$PCB"
"$KICAD_CLI" pcb export pdf --mode-single --layers "User.2,B.Courtyard,Edge.Cuts" --mirror --include-border-title -o assemblage_bottom.pdf "$PCB"
pdfunite assemblage_top.pdf assemblage_bottom.pdf "$OUT"
rm assemblage_top.pdf assemblage_bottom.pdf
echo "OK -> $OUT"
