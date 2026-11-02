# Contributing to ProSEO

Thanks for helping. Bug reports, fixes, sharper checks and new skills are all
welcome. This page covers how to set up a working copy, what the checks expect,
and how a release is cut.

## Reporting

- **Bugs and feature requests:** open an
  [issue](https://github.com/theahmadraza/ProSEO/issues/new/choose). Include the
  command you ran, the URL or input (use a public test site if the real one is
  private), what you expected and what happened.
- **Security issues:** never in a public issue. Follow [SECURITY.md](SECURITY.md).

## Set up a working copy

ProSEO needs Python 3.10 or newer.

```bash
git clone https://github.com/theahmadraza/ProSEO.git
cd ProSEO
python3 -m venv .venv
.venv/bin/pip install -r requirements.txt pytest
```

To try your copy inside Claude Code, add it as a local marketplace:

```
/plugin marketplace add ./ProSEO
/plugin install pro-seo@pro-seo
/pro-seo setup
```

## Checks to run before a pull request

CI runs all three, plus a guard that rejects developer-machine paths and private
identifiers.

```bash
.venv/bin/python -m pytest tests/ -q
.venv/bin/python scripts/consistency_check.py
.venv/bin/python scripts/portability_check.py
```

`consistency_check.py` must report 0 errors. It fails on dead references,
orphan files, and routing drift between `skills/pro-seo/SKILL.md` and
`docs/COMMANDS.md`.

## Conventions

- `SKILL.md` files stay under 500 lines; reference files under 200 lines.
- Skill directories are kebab-case and prefixed `pro-seo-`.
- Scripts have a module docstring, a CLI, and JSON output. New scripts carry the
  SPDX header used by the existing ones:

  ```python
  # SPDX-License-Identifier: AGPL-3.0-or-later
  # Copyright (c) 2026 Ahmad Raza
  ```

- Any script that fetches a user-supplied URL goes through `scripts/url_safety.py`
  (`validate_url_strict()` and the pinned safe fetchers). No exceptions.
- Skills call bundled tools as `pro-seo run <script>.py`, never with a bare
  Python interpreter.
- Never commit credentials, client data, or paths from your own machine.

## Adding a skill

1. Create `skills/pro-seo-<name>/SKILL.md` with `name`, `description`,
   `license` and `metadata.version` frontmatter.
2. Add its route to `skills/pro-seo/SKILL.md` and `docs/COMMANDS.md`.
3. Update the skill count everywhere it is stated: `plugin.json`,
   `marketplace.json`, `README.md`, `CLAUDE.md` and `AGENTS.md`. The test suite
   fails if any of them disagree with the number of directories in `skills/`.

## Releases

Installed copies update only when the version changes, so every release bumps it.

1. Set the new version in `.claude-plugin/plugin.json`, `pyproject.toml`, the
   default tag in `install.sh` and `install.ps1`, and every `metadata.version`
   in `SKILL.md` frontmatter (community skills listed in `COMMUNITY_OVERRIDES`
   keep their own). `tests/test_manifest_consistency.py` checks they agree.
2. Add a dated section to [CHANGELOG.md](CHANGELOG.md).
3. Merge to `main`, tag `v<version>`, and publish a GitHub Release with the
   manifest from `python scripts/release_sign.py > release-manifest.json`
   attached.

## Licence

ProSEO is [AGPL-3.0-or-later](LICENSE). By opening a pull request you agree that
your contribution is licensed under the same terms. Upstream and community
credits are in [CONTRIBUTORS.md](CONTRIBUTORS.md) and [NOTICE](NOTICE); keep
those notices intact.
