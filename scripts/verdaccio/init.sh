#!/bin/bash

VERDACCIO_DIR=".verdaccio"
CONFIG_FILE="$VERDACCIO_DIR/config.yaml"
STORAGE_DIR="$VERDACCIO_DIR/storage"
PLUGINS_DIR="$VERDACCIO_DIR/plugins"
HTPASSWD_FILE="$VERDACCIO_DIR/htpasswd"

NODE_VERSION=$(node -v)

echo "🛢️ Preparing Verdaccio config…"
echo "🔍 Node version: $NODE_VERSION"

mkdir -p "$VERDACCIO_DIR" "$STORAGE_DIR" "$PLUGINS_DIR"
touch "$HTPASSWD_FILE"

### -------------------------------------------------------
### Verdaccio Config (v4 vs v6)
### -------------------------------------------------------

if [[ "$NODE_VERSION" == "v14.15.4" ]]; then
    echo "⚠️ Node v14.15.4 detected → Generating Verdaccio 4 config"

cat <<EOF > "$CONFIG_FILE"
storage: ./storage
auth:
  htpasswd:
    file: ./htpasswd
uplinks:
  npmjs:
    url: https://registry.npmjs.org/
packages:
  '@*/*':
    access: $all
    publish: $all
  '**':
    access: $all
    publish: $all
listen: 4873
EOF

else
    echo "✅ Generating Verdaccio 6 config"

cat <<EOF > "$CONFIG_FILE"
storage: ./storage
plugins: ./plugins

web:
  title: Galata Local Registry

auth:
  htpasswd:
    file: ./htpasswd
    max_users: 1000

uplinks:
  npmjs:
    url: https://registry.npmjs.org/

packages:
  '@*/*':
    access: $all
    publish: $all
    unpublish: $all
    proxy: npmjs

  '**':
    access: $all
    publish: $all
    unpublish: $all
    proxy: npmjs

server:
  keepAliveTimeout: 60

middlewares:
  audit:
    enabled: true

logs:
  - { type: stdout, format: pretty, level: http }
EOF

fi

echo "🎯 Verdaccio config.yaml created"

### -------------------------------------------------------
###  AUTOMATIC LOCAL USER CREATION
### -------------------------------------------------------

LOCAL_NPMRC="$HOME/.npmrc"
REG="http://localhost:4873/"

echo "👤 Preparing local Verdaccio user..."

# Skip if already exists
if grep -q "$REG" "$LOCAL_NPMRC" 2>/dev/null; then
    echo "ℹ️ Local npm user already exists → skipping."
else
    echo "📌 Creating Galata default npm user..."

    # htpasswd generation (username: Galata, password: Galata)
    npx htpasswd -b "$HTPASSWD_FILE" Galata Galata

    # Add token into .npmrc
    echo "//localhost:4873/:_authToken=\"Galata-token\"" >> "$LOCAL_NPMRC"
    echo "always-auth=true" >> "$LOCAL_NPMRC"

    echo "✅ Local npm user created:"
    echo "   username: Galata"
    echo "   password: Galata"
    echo "   email: Galata@example.com"
fi

echo "🍀 Verdaccio init completed."