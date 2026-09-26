#!/usr/bin/env bash
# SPDX-License-Identifier: AGPL-3.0-or-later
# Copyright (c) 2026 Ahmad Raza
# ProSEO — Unlighthouse extension installer.
#
# Wraps the existing scripts/unlighthouse_run.py into a discoverable
# pro-seo-unlighthouse skill. No API keys — Unlighthouse is fully local,
# MIT-licensed, runs on top of Lighthouse via npx.
set -euo pipefail

main() {
    SKILL_DIR="${HOME}/.claude/skills"

    echo "════════════════════════════════════════"
    echo "║   ProSEO — Unlighthouse           ║"
    echo "════════════════════════════════════════"

    command -v python3 >/dev/null 2>&1 || { echo "✗ Python 3 required."; exit 1; }
    command -v npx     >/dev/null 2>&1 || { echo "✗ Node 18+ / npx required."; exit 1; }
    [ ! -d "${SKILL_DIR}/pro-seo" ] && { echo "✗ pro-seo base not installed."; exit 1; }

    SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" >/dev/null 2>&1 && pwd)"

    echo "→ Pre-warming unlighthouse..."
    npx --yes --package=unlighthouse@0.13.5 unlighthouse-ci --help >/dev/null 2>&1 || true

    mkdir -p "${SKILL_DIR}/pro-seo-unlighthouse"
    cp "${SOURCE_DIR}/skills/pro-seo-unlighthouse/SKILL.md" "${SKILL_DIR}/pro-seo-unlighthouse/SKILL.md"
    echo "✓ Installed skill: ${SKILL_DIR}/pro-seo-unlighthouse"
    echo "Done. Try: /pro-seo unlighthouse https://example.com"
}
main "$@"
