#!/usr/bin/env bash
set -e

echo "🧹 Galata — CLEAN process starting..."

# Root safety check
if [ ! -f "pnpm-workspace.yaml" ]; then
  echo "❌ pnpm-workspace.yaml not found. Are you in repo root?"
  exit 1
fi

# 1. Remove all node_modules safely
echo "📦 Removing all node_modules..."
find . -type d -name "node_modules" -prune -exec rm -rf '{}' +

# 2. Remove dist folders
echo "🗑️ Cleaning dist folders..."
find . -type d -name "dist" -prune -exec rm -rf '{}' +

# 3. Remove build folders
echo "🗑️ Cleaning build folders..."
find . -type d -name "build" -prune -exec rm -rf '{}' +

# 4. Remove turbo cache
echo "⚡ Removing .turbo cache..."
rm -rf .turbo

# 5. Remove nx cache (future-proof)
rm -rf .nx 2>/dev/null || true

# 6. Remove ts build cache
echo "🧩 Cleaning tsbuildinfo..."
find . -type f -name "*.tsbuildinfo" -delete

# 7. pnpm store prune
echo "📦 Running pnpm store prune..."
pnpm store prune

# 8. Remove lock file (optional)
echo "🔐 Removing pnpm-lock.yaml..."
rm -f pnpm-lock.yaml

# 9. Verdaccio cleanup (if exists)
if [ -d ".verdaccio" ]; then
  echo "🗑️ Removing .verdaccio directory..."
  rm -rf .verdaccio
fi

echo "🎉 Cleanup complete! You can now run a fresh setup:"
echo "👉 pnpm run l:setup"