#!/usr/bin/env bash
# install.sh - link dotfiles into place on Linux (also works on macOS)
# Usage (from anywhere):
#   bash install.sh
#
# Mirrors install.ps1; keep the two link lists in sync.

set -euo pipefail
repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Each entry: "source in the repo|target on this machine".
# Add more lines here later (settings.json, commands, agents, ...).
links=(
    "$repo/claude/CLAUDE.md|$HOME/.claude/CLAUDE.md"
)

for link in "${links[@]}"; do
    src="${link%%|*}"
    dst="${link#*|}"

    if [[ ! -e "$src" ]]; then
        echo "Warning: source not found, skipping: $src" >&2
        continue
    fi

    # Make sure the parent folder exists
    mkdir -p "$(dirname "$dst")"

    # Handle anything already at the target (-L also catches broken links)
    if [[ -L "$dst" ]]; then
        if [[ "$(readlink "$dst")" == "$src" ]]; then
            echo "Already linked: $dst"
            continue
        fi
        rm "$dst"
    elif [[ -e "$dst" ]]; then
        backup="$dst.bak-$(date +%Y%m%d-%H%M%S)"
        mv "$dst" "$backup"
        echo "Backed up existing file to $backup"
    fi

    ln -s "$src" "$dst"
    echo "Linked $dst -> $src"
done
