# Sync Public Exemplar

This GitHub Actions workflow demonstrates how to sync artifacts from a private repository into a public repository for use in a public portfolio.

## Context

A private repository is currently used for all dbt project work related to lessons and portfolio exemplars. The private repository is structured to keep different subprojects isolated. When changes are made in the private repository that are part of a public exemplar, GitHub Actions workflow moves the updated artifacts to the public repository.  

## How it works

- **Trigger:** Runs on push to `main` in the private repository, scoped to changes in `/jaffle_shop` and `/models/jaffle_shop`.

- **Checkouts:**
  - Private repository is checked out into workspace folder `/private`.
  - Public repository is checked out into workspace folder `/public`.

- **Sync:**
  - Non-model artifacts (`/macros`, `/seeds`, etc.) are copied into `/public`.
  - Model artifacts in `/models` are copied into `/public/models`.
  - The `/.git` directory is excluded to preserve the public repository.

- **Rename:** `*.sqlx` files in `/public/macros` are renamed to `.sql`.
  - `.sqlx` files are used for macro exemplars; renaming ensures compatibility with dbt while preserving exemplar intent.

- **Commit:** Public repository commits are authored by `github-actions[bot]` with a provenance message that includes the private commit SHA.

## Requirements

- A private repository secret `PAT_Public_JaffleShop` tied to a Personal Access Token (PAT) with content read/write permissions to the public repository.
  - **Best practice:** scope the PAT to only the target repository, not org‑wide, to minimize exposure.
