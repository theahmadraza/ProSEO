#!/usr/bin/env bash
# SPDX-License-Identifier: AGPL-3.0-or-later
# Copyright (c) 2026 Ahmad Raza
set -euo pipefail

# ProSEO Installer
# Wraps everything in main() to prevent partial execution on network failure

main() {
    SKILL_DIR="${HOME}/.claude/skills/pro-seo"
    AGENT_DIR="${HOME}/.claude/agents"
    # Pin to a specific release tag to prevent silent updates from main.
    # This default MUST be bumped on every release. CI guard
    # (tests/test_manifest_consistency.py) enforces this matches plugin.json.
    # Override: PRO_SEO_TAG=main bash install.sh
    REPO_TAG="${PRO_SEO_TAG:-v1.0.0}"

    echo "════════════════════════════════════════"
    echo "║   ProSEO - Installer             ║"
    echo "║   Claude Code SEO Skill              ║"
    echo "════════════════════════════════════════"
    echo ""

    # Check prerequisites. The runtime launcher performs cross-platform Python
    # resolution and validates the minimum supported version.
    # Create directories
    mkdir -p "${SKILL_DIR}"
    mkdir -p "${AGENT_DIR}"

    # Install from this repository checkout
    SRC_DIR="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
    echo "→ Installing ProSEO (${REPO_TAG}) from ${SRC_DIR}..."

    # Copy skill files
    echo "→ Installing skill files..."
    cp -r "${SRC_DIR}/skills/pro-seo/"* "${SKILL_DIR}/"

    # Copy sub-skills
    if [ -d "${SRC_DIR}/skills" ]; then
        for skill_dir in "${SRC_DIR}/skills"/*/; do
            skill_name=$(basename "${skill_dir}")
            target="${HOME}/.claude/skills/${skill_name}"
            mkdir -p "${target}"
            cp -r "${skill_dir}"* "${target}/"
        done
    fi

    # Copy schema templates
    if [ -d "${SRC_DIR}/schema" ]; then
        mkdir -p "${SKILL_DIR}/schema"
        cp -r "${SRC_DIR}/schema/"* "${SKILL_DIR}/schema/"
    fi

    # Copy reference docs
    if [ -d "${SRC_DIR}/pdf" ]; then
        mkdir -p "${SKILL_DIR}/pdf"
        cp -r "${SRC_DIR}/pdf/"* "${SKILL_DIR}/pdf/"
    fi

    # Copy agents
    echo "→ Installing subagents..."
    cp -r "${SRC_DIR}/agents/"*.md "${AGENT_DIR}/" 2>/dev/null || true

    # Copy shared scripts
    if [ -d "${SRC_DIR}/scripts" ]; then
        mkdir -p "${SKILL_DIR}/scripts"
        cp -r "${SRC_DIR}/scripts/"* "${SKILL_DIR}/scripts/"
    fi

    # Copy the stable runtime launcher. Manual installs use its explicit path;
    # plugin installs expose the repository bin/ directory automatically.
    if [ -f "${SRC_DIR}/bin/pro-seo" ]; then
        mkdir -p "${SKILL_DIR}/bin"
        cp "${SRC_DIR}/bin/pro-seo" "${SKILL_DIR}/bin/pro-seo"
        chmod +x "${SKILL_DIR}/bin/pro-seo"
    fi

    # Copy hooks
    if [ -d "${SRC_DIR}/hooks" ]; then
        mkdir -p "${SKILL_DIR}/hooks"
        cp -r "${SRC_DIR}/hooks/"* "${SKILL_DIR}/hooks/"
        chmod +x "${SKILL_DIR}/hooks/"*.sh 2>/dev/null || true
        chmod +x "${SKILL_DIR}/hooks/"*.py 2>/dev/null || true
        # Manual installs copy hook files only; enforcement loads through the plugin manifest.
        echo "  Note: hook enforcement requires plugin install (/plugin install pro-seo@pro-seo); manual hook copy is best-effort."
    fi

    # Copy extensions (optional add-ons: dataforseo, banana)
    if [ -d "${SRC_DIR}/extensions" ]; then
        echo "=> Installing extensions..."
        for ext_dir in "${SRC_DIR}/extensions"/*/; do
            [ -d "${ext_dir}" ] || continue
            ext_name=$(basename "${ext_dir}")
            # Extension skills
            if [ -d "${ext_dir}skills" ]; then
                for ext_skill in "${ext_dir}skills"/*/; do
                    [ -d "${ext_skill}" ] || continue
                    ext_skill_name=$(basename "${ext_skill}")
                    target="${HOME}/.claude/skills/${ext_skill_name}"
                    mkdir -p "${target}"
                    cp -r "${ext_skill}"* "${target}/"
                done
            fi
            # Extension agents
            if [ -d "${ext_dir}agents" ]; then
                cp -r "${ext_dir}agents/"*.md "${AGENT_DIR}/" 2>/dev/null || true
            fi
            # Extension references
            if [ -d "${ext_dir}references" ]; then
                mkdir -p "${SKILL_DIR}/extensions/${ext_name}/references"
                cp -r "${ext_dir}references/"* "${SKILL_DIR}/extensions/${ext_name}/references/"
            fi
            # Extension scripts
            if [ -d "${ext_dir}scripts" ]; then
                mkdir -p "${SKILL_DIR}/extensions/${ext_name}/scripts"
                cp -r "${ext_dir}scripts/"* "${SKILL_DIR}/extensions/${ext_name}/scripts/"
            fi
        done
    fi

    # Copy requirements.txt to skill dir so users can retry later
    cp "${SRC_DIR}/requirements.txt" "${SKILL_DIR}/requirements.txt" 2>/dev/null || true
    cp "${SRC_DIR}/.claude-plugin/plugin.json" "${SKILL_DIR}/runtime-plugin.json" 2>/dev/null || true

    # Manual installs cannot rely on plugin bin/ PATH injection. Rewrite only
    # exact files copied from this checkout during this install.
    rewrite_doc() {
        local doc="$1" temp_doc
        temp_doc="${doc}.pro-seo-tmp"
        sed -e 's#pro-seo run#"$HOME/.claude/skills/pro-seo/bin/pro-seo" run#g' \
            -e 's#pro-seo setup#"$HOME/.claude/skills/pro-seo/bin/pro-seo" setup#g' \
            -e 's#pro-seo doctor#"$HOME/.claude/skills/pro-seo/bin/pro-seo" doctor#g' \
            "${doc}" > "${temp_doc}"
        mv "${temp_doc}" "${doc}"
    }
    for source_root in "${SRC_DIR}/skills"/*; do
        [ -d "${source_root}" ] || continue
        skill_name=$(basename "${source_root}")
        while IFS= read -r -d '' source_doc; do
            relative_doc=${source_doc#"${source_root}/"}
            doc="${HOME}/.claude/skills/${skill_name}/${relative_doc}"
            [ -f "${doc}" ] && rewrite_doc "${doc}"
        done < <(find "${source_root}" -type f -name '*.md' -print0)
    done
    for source_root in "${SRC_DIR}/extensions"/*/skills/*; do
        [ -d "${source_root}" ] || continue
        skill_name=$(basename "${source_root}")
        while IFS= read -r -d '' source_doc; do
            relative_doc=${source_doc#"${source_root}/"}
            doc="${HOME}/.claude/skills/${skill_name}/${relative_doc}"
            [ -f "${doc}" ] && rewrite_doc "${doc}"
        done < <(find "${source_root}" -type f -name '*.md' -print0)
    done
    for source_root in "${SRC_DIR}/extensions"/*/references; do
        [ -d "${source_root}" ] || continue
        ext_name=$(basename "$(dirname "${source_root}")")
        while IFS= read -r -d '' source_doc; do
            relative_doc=${source_doc#"${source_root}/"}
            doc="${SKILL_DIR}/extensions/${ext_name}/references/${relative_doc}"
            [ -f "${doc}" ] && rewrite_doc "${doc}"
        done < <(find "${source_root}" -type f -name '*.md' -print0)
    done
    for source_doc in "${SRC_DIR}/agents"/*.md "${SRC_DIR}/extensions"/*/agents/*.md; do
        [ -f "${source_doc}" ] || continue
        doc="${AGENT_DIR}/$(basename "${source_doc}")"
        [ -f "${doc}" ] && rewrite_doc "${doc}"
    done

    echo "→ Creating isolated Python runtime..."
    set +e
    "${SKILL_DIR}/bin/pro-seo" setup
    runtime_status=$?
    set -e
    if [ "${runtime_status}" -ne 0 ] && [ "${runtime_status}" -ne 10 ]; then
        echo "✗ Core Python runtime setup failed. Installation is incomplete." >&2
        exit 1
    elif [ "${runtime_status}" -eq 10 ]; then
        echo "⚠ Core runtime installed, but Chromium setup is incomplete." >&2
    fi

    echo ""
    echo "✓ ProSEO installed successfully!"
    echo ""
    echo "Usage:"
    echo "  1. Start Claude Code:  claude"
    echo "  2. Run commands:       /pro-seo audit https://example.com"
    echo ""
    echo "Python deps location: ${SKILL_DIR}/requirements.txt"
    echo "Inspect remote scripts before piping them to bash."
    echo "To uninstall: bash uninstall.sh (from this directory)"
}

main "$@"
