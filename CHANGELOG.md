# Changelog

All notable changes to ProSEO are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and ProSEO adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Updates reach installed users only when this version number changes.

## [1.0.2] — 2026-11-02

### Changed

- Third-party notices are consolidated in `NOTICE` and each skill's
  `LICENSE.txt`. The README, `CONTRIBUTORS.md`, `CLAUDE.md`, `AGENTS.md`,
  skill frontmatter, agent and reference files no longer repeat them.

## [1.0.1] — 2026-11-02

### Added

- `CONTRIBUTING.md` with setup, the checks CI runs, conventions and the release
  steps; issue forms for bugs, feature requests and licensing questions; a pull
  request template
- `plugin.json` now names the repository, and its homepage is the
  documentation site, https://pro-seo.info

### Changed

- The CI leak guard reads its private patterns from a repository secret instead
  of listing them in the workflow, and reports matches by location only
- CI uses `actions/checkout@v5` and `actions/setup-python@v6`

### Fixed

- `CLAUDE.md` and `AGENTS.md` gave the orchestrator path as `skills/seo/`
  (it is `skills/pro-seo/`) and omitted the lifecycle, keywords,
  internal-links, refresh, migration and report skills and the setup and
  doctor commands
- `CLAUDE.md` listed `mobile_analysis.py`, which does not ship, instead of
  `runtime.py`
- The orchestrator stated its sub-skill breakdown as 28 core; it routes to 27
  core skills, the framework integration and two extension mirrors
- Removed version labels inherited from the upstream project (v1.9.0, v2.0.0)
  from the docs and agents, and upstream leftovers from `.gitignore`

## [1.0.0] — 2026-09-27

First public release.

### Added

- 31 sub-skills and 18 specialist agents covering the SEO Lifecycle: Discover,
  Plan, Build, Optimize, Authority, Measure, Iterate
- Technical SEO across 9 categories, content quality and E-E-A-T, Schema.org
  generation and validation, sitemap architecture, image optimization,
  AI-search optimization (GEO), local SEO and maps intelligence, backlinks,
  semantic clustering, search experience optimization, e-commerce SEO,
  hreflang, keyword research, internal linking, content refresh, migrations,
  reporting and drift monitoring
- 53 bundled Python tools dispatched through `pro-seo run`, with SSRF-safe
  fetching, SPA-aware rendering, and Google Search Console, PageSpeed Insights,
  CrUX and GA4 clients
- 8 optional MCP extensions: DataForSEO, Firecrawl, Banana, Ahrefs, SE Ranking,
  Profound, Bing Webmaster and Unlighthouse
- `NOTICE` recording the AGPL terms, third-party notices, and the ProSEO
  trademark
- Continuous integration running the consistency gate, the test suite and a
  guard against private paths and client identifiers

### Changed

- Licence is now **AGPL-3.0-or-later**, copyright © 2026 Ahmad Raza.
  Third-party portions keep their original licences, reproduced in `NOTICE`.
- `/pro-seo lifecycle` no longer carries a built-in default site. It takes the
  URL argument, falls back to an in-progress `pro-seo-lifecycle.json`, and
  otherwise asks.

### Removed

- The `pro-seo-publish` skill, which was hardcoded to one private Next.js
  checkout and could not work for anyone else
