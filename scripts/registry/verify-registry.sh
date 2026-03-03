#!/bin/bash

echo "🔍 Checking registry..."

CURRENT=$(pnpm config get registry)

if [[ "$CURRENT" == "http://localhost:4873/" ]]; then
  echo "✅ Verdaccio registry is active"
else
  echo "⚠️ WARNING: Registry is currently on NPM!"
  echo "To fix:"
  echo "pnpm registry:local"
fi