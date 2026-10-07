#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")/.."

# Xcode launched from Finder does not inherit the terminal's Homebrew PATH.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

if ! command -v swiftformat >/dev/null 2>&1; then
  echo "error: SwiftFormat is required. Install it with: brew install swiftformat" >&2
  exit 1
fi

swiftformat Atelier/Sources Tuist Project.swift Tuist.swift --config .swiftformat --cache ignore
