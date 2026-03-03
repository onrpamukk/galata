#!/bin/bash

echo "🔧 Local registry (Verdaccio) activated..."

pnpm config set registry http://localhost:4873/
npm config set registry http://localhost:4873/

echo "✅ Local registry activated"