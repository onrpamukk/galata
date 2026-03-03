#!/bin/bash

echo "🔄 Registry → Global NPM"

pnpm config set registry https://registry.npmjs.org/
npm config set registry https://registry.npmjs.org/

echo "✅ Global registry active"