#!/usr/bin/env bash
# SPDX-License-Identifier: AGPL-3.0-or-later
# Copyright (c) 2026 Ahmad Raza
set -euo pipefail
SKILL_DIR="${HOME}/.claude/skills/pro-seo-unlighthouse"
[ -d "${SKILL_DIR}" ] && rm -rf "${SKILL_DIR}" && echo "✓ Removed ${SKILL_DIR}"
echo "Done. (Nothing to remove from settings.json — Unlighthouse has no keys.)"
