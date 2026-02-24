# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is the **distant.dev** documentation website for the [Distant](https://github.com/chipsenkbeil/distant) project (remote machine tooling and libraries). Built with MkDocs Material (Insiders Edition) and deployed to Cloudflare Pages via GitHub Actions.

## Build & Serve Commands

```sh
mkdocs serve          # Local dev server with live reload
mkdocs build          # Generate static site into site/
```

Deployment happens automatically on push to `main` via GitHub Actions (`mkdocs gh-deploy --force`). Do not deploy manually.

## Dependencies Setup

```sh
pip install mkdocs-material          # Or Insiders edition from private repo
pip install mkdocs-macros-plugin
pip install mkdocs-mermaid2-plugin
pip install pillow cairosvg
brew install pngquant cairo freetype libffi libjpeg libpng zlib
curl -L https://sh.distant.dev | sh  # Install distant CLI (needed for help doc generation)
```

## Architecture

- **`mkdocs.yml`** — Main config: navigation structure, theme settings, plugins, markdown extensions
- **`macros.py`** — Python macros available in markdown files via Jinja2 templating:
  - `asciinema(file, **kwargs)` — Embeds terminal recording player
  - `issue(num)` — Generates GitHub issue link
  - `run(cmd, ...)` — Executes shell command and embeds output (used for CLI help docs)
  - Feature icons: `f_full`, `f_partial`, `f_none` for feature support tables
- **`docs/`** — All markdown source files organized by section (getting-started, editors, reference, about)
- **`overrides/home.html`** — Custom landing page template extending Material theme
- **`docs/stylesheets/extra.css`** — Custom theme colors (#41ACC9 primary, #C95E41 accent)
- **`docs/static/`** — Installer scripts (shell and PowerShell) for the distant binary
- **`cloudflare/worker.js`** — Cloudflare Worker for sh.distant.dev that detects OS and redirects to the appropriate installer script

## Key Conventions

- Macros plugin runs with `on_error_fail: true` and `on_undefined: strict` — any undefined variable or macro error will fail the build
- The `run()` macro executes the `distant` CLI at build time, so the distant binary must be installed locally to build successfully
- Mermaid diagrams use a custom fence format configured through `mermaid2` plugin (`mermaid2.fence_mermaid_custom`)
- Image assets in `docs/assets/` include multiple formats (AVIF, WebP, PNG) for optimization; the `optimize` plugin handles PNG compression via pngquant
- The site uses Material for MkDocs Insiders features; building with the standard edition works but some features will be missing or not rendered
