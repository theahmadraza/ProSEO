# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability in ProSEO, please report it privately
through GitHub's private vulnerability reporting: open the **Security** tab of
[the repository](https://github.com/theahmadraza/ProSEO/security/advisories/new)
and submit an advisory. Do not open a public issue.

Include a short description of the issue and its impact, a minimal reproducer
(URL, command line, payload, or short script), and affected versions/platforms.

## Scope notes

- Bundled fetchers are SSRF/DNS-rebinding hardened (`scripts/url_safety.py`);
  regressions there are always in scope.
- Release artifacts can be verified with `scripts/verify_release.py`.
