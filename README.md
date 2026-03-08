# Samir Bettahar CV

LaTeX source for my multilingual CV set (English, French, Arabic), built with `awesome-cv` and published as PDF.

## Repository Layout

- `Bettahar-Samir-Resume.tex`: English CV
- `Bettahar-Samir-CV.tex`: French CV
- `Bettahar-Samir-Ar-CV.tex`: Arabic CV
- `sections/`: language-specific section content
- `fonts/`: local fonts used by the template
- `private-vars.example.tex`: template for local private values
- `scripts/sync-to-portfolio.sh`: build + copy PDFs into `portfolio/public/cv`
- `output/`: generated build artifacts

## Requirements

- `xelatex`
- `make`

On Ubuntu/Debian, this usually means:

```bash
sudo apt-get update
sudo apt-get install -y make texlive-xetex texlive-latex-extra texlive-fonts-extra texlive-lang-arabic fonts-freefont-otf
```

## Build

Default build is public mode.

```bash
make public
```

Private build includes extra contact details and photo.

Before first private build:

```bash
cp private-vars.example.tex private-vars.tex
```

```bash
make private
```

Build a single language:

```bash
make en
make fr
make ar
```

Clean artifacts:

```bash
make clean
```

## Privacy Modes

Public mode (default):

- Shows name, role, email alias, GitHub, LinkedIn, website
- Hides WhatsApp number, address, photo

Private mode (`make private`):

- Loads WhatsApp, address, and photo path from local `private-vars.tex` (not tracked)

## Portfolio Sync

Build public PDFs and copy them to the portfolio static folder:

```bash
./scripts/sync-to-portfolio.sh
```

Target folder expected:

- `$HOME/developer/personal/portfolio/public/cv`

## CI and Releases

- Pull requests and pushes are validated by GitHub Actions build workflow.
- Tag pushes matching `v*` create a GitHub Release and attach the generated PDF files.

## License

- Repository content is licensed under the MIT License (see `LICENSE`).
- Third-party template and assets notices are listed in `THIRD_PARTY_NOTICES.md`.
