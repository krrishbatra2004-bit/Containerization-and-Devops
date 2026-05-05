# PDF Generation Requirements

To run the `generate_report.sh` script, you need the following tools installed:

### 1. Pandoc
Download and install from [pandoc.org](https://pandoc.org/installing.html).

### 2. LaTeX (MikTeX or TeX Live)
- **Windows**: [MikTeX](https://miktex.org/download) is recommended.
- **WSL/Linux**: `sudo apt install texlive-xetex texlive-fonts-recommended texlive-plain-generic`

### 3. Fonts
The script uses `DejaVu Sans`. If you don't have it, you can change the font in `generate_report.sh` (search for `-V mainfont`).

### How to Run:
1. Open **Git Bash** or **WSL** in the project root.
2. Make the script executable:
   ```bash
   chmod +x generate_report.sh
   ```
3. Run the script:
   ```bash
   ./generate_report.sh
   ```

The script will gather all experiments from `Lab/Exp1` to `Lab/Exp12`, fix the image paths, and generate a single professional PDF named `Containerization_DevOps_Report.pdf`.
