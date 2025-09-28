#!/usr/bin/env bash
set -euo pipefail

echo "🔎 Verifying code style before push (spotless + checkstyle)..."
./gradlew --no-daemon -q spotlessCheck checkstyleMain
echo "✅ Style checks passed. Proceeding with push."
