#!/bin/bash

# ==============================================================================
# DevOps Lab Portfolio PDF Generator (Final Stability Fix)
# ==============================================================================

# 1. Configuration
NAME="Krrish Batra"
SAPID="500119657"
ROLLNO="R2142230486"
BATCH="2"
COURSE="Containerization and DevOps"
TITLE="Containerization and DevOps Lab Portfolio"
GITHUB_REPO="https://github.com/krrishbatra2004-bit/Containerization-and-Devops"
GITHUB_PAGES="https://krrishbatra2004-bit.github.io/Containerization-and-Devops/"
OUTPUT_PDF="Containerization_DevOps_Report.pdf"
TEMP_MD="build_report.md"
METADATA_YAML="metadata.yaml"
HEADER_TEX="header_auto.tex"

# 2. Dependency Check
echo "Checking dependencies..."
if ! command -v pandoc &> /dev/null || ! command -v xelatex &> /dev/null; then
    echo "Missing dependencies. Run the installation command provided earlier."
    exit 1
fi

# 3. Create LaTeX Header
cat > "$HEADER_TEX" << 'LATEX_EOF'
\usepackage{fancyhdr}
\usepackage{graphicx}
\usepackage{hyperref}
\usepackage{xcolor}
\usepackage{geometry}
\usepackage{sectsty}
\definecolor{primary}{RGB}{0, 51, 102}
\definecolor{secondary}{RGB}{100, 100, 100}
\geometry{a4paper, margin=1in}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\small\textcolor{secondary}{Containerization and DevOps Lab Report}}
\fancyhead[R]{\small\textcolor{secondary}{\thepage}}
\fancyfoot[C]{\small\textcolor{secondary}{Krrish Batra --- 500119657}}
\renewcommand{\headrulewidth}{0.4pt}

% Fix Image Formatting (Scale and Center)
\usepackage{float}
\makeatletter
\def\maxwidth{\ifdim\Gin@nat@width>\linewidth\linewidth\else\Gin@nat@width\fi}
\def\maxheight{\ifdim\Gin@nat@height>\textheight\textheight\else\Gin@nat@height\fi}
\makeatother
\setkeys{Gin}{width=\maxwidth,height=\maxheight,keepaspectratio}

% Force images to stay in place and be centered
\let\origfigure\figure
\let\endorigfigure\endfigure
\renewenvironment{figure}[1][H] {
    \origfigure[H]
    \centering
} {
    \endorigfigure
}

\sectionfont{\color{primary}\large}
\subsectionfont{\color{primary}}
LATEX_EOF

# 4. Create Metadata YAML
cat > "$METADATA_YAML" << EOF
---
title: "$TITLE"
author: "$NAME ($SAPID)"
date: "$(date '+%B %d, %Y')"
toc: true
toc-depth: 2
---
EOF

# 5. Helper: strip YAML and replace problematic horizontal rules
process_markdown() {
    local file="$1"
    local exp_dir="$2"
    
    # 1. Strip YAML frontmatter if it exists
    # 2. Replace '---' with '***' to prevent Pandoc from seeing them as YAML starts
    # 3. Fix image paths
    awk '
        BEGIN { count=0; show=1 }
        /^---$/ { 
            count++; 
            if (count == 1 && NR == 1) { show=0; next } 
            if (count == 2 && show == 0) { show=1; next }
        }
        { if (show) print }
    ' "$file" | \
    sed 's/^---[[:space:]]*$/\*\*\*/g' | \
    sed -E "s|\(\./[Ii]mages/|(${exp_dir}/images/|g; s|\(([Ii]mages)/|(${exp_dir}/images/|g"
}

# 6. Build consolidated report
echo "Building consolidated report..."
cat > "$TEMP_MD" << COVER_EOF
# Portfolio Overview

| Field | Details |
|:------|:--------|
| **Student Name** | $NAME |
| **SAP ID** | $SAPID |
| **Roll Number** | $ROLLNO |
| **Batch** | $BATCH |
| **Course** | $COURSE |
| **GitHub Repository** | <$GITHUB_REPO> |
| **Live Report** | <$GITHUB_PAGES> |

\\newpage
COVER_EOF

for i in {1..12}; do
    FILE="Lab/Exp${i}/Exp${i}.md"
    if [ -f "$FILE" ]; then
        echo "  Adding Experiment $i..."
        printf '\n\\newpage\n' >> "$TEMP_MD"
        process_markdown "$FILE" "Lab/Exp${i}" >> "$TEMP_MD"
    fi
done

# 7. Generate PDF
echo "Generating PDF..."
pandoc "$METADATA_YAML" "$TEMP_MD" \
    -o "$OUTPUT_PDF" \
    --pdf-engine=xelatex \
    -H "$HEADER_TEX" \
    --toc \
    --number-sections \
    --resource-path=.

if [ $? -eq 0 ]; then
    echo "✅ Success! PDF created: $OUTPUT_PDF"
    rm -f "$TEMP_MD" "$METADATA_YAML" "$HEADER_TEX"
else
    echo "❌ Error: PDF generation failed."
fi
