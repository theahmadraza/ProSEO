# SPDX-License-Identifier: AGPL-3.0-or-later
# Copyright (c) 2026 Ahmad Raza
$ErrorActionPreference = "Stop"
if (-not (Get-Command python -ErrorAction SilentlyContinue)) { throw "Python 3 required" }
if (-not (Get-Command npx -ErrorAction SilentlyContinue))    { throw "Node 18+ / npx required" }
$SkillDir = Join-Path $HOME ".claude/skills"
if (-not (Test-Path (Join-Path $SkillDir "seo"))) { throw "pro-seo not installed" }
$SourceDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SkillTarget = Join-Path $SkillDir "pro-seo-unlighthouse"
New-Item -ItemType Directory -Path $SkillTarget -Force | Out-Null
Copy-Item (Join-Path $SourceDir "skills/pro-seo-unlighthouse/SKILL.md") `
          (Join-Path $SkillTarget "SKILL.md") -Force
& npx --yes --package=unlighthouse@0.13.5 unlighthouse-ci --help *> $null
Write-Host "Done."
