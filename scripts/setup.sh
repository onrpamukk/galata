#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

echo "🔥 Galata — Global Setup Starting..."

### ---------------------------
### 1. pnpm Check
### ---------------------------
if ! command -v pnpm &> /dev/null
then
    echo "❌ pnpm is not installed!"
    echo "To install:"
    echo "curl -fsSL https://get.pnpm.io/install.sh | sh -"
    exit 1
fi

echo "✅ pnpm found"


### ---------------------------
### 2. Install root dependencies
### ---------------------------
echo "📦 Installing root dependencies..."
pnpm install -w

### ---------------------------
### 2.5 Determine Verdaccio version by Node version
### ---------------------------
NODE_VERSION=$(node -v)
VERDACCIO_VERSION="6"   # default

if [[ "$NODE_VERSION" == "v14.15.4" ]]; then
    echo "⚠️ Node v14.15.4 detected → Verdaccio 4.13.2 will be used"
    VERDACCIO_VERSION="4.13.2"
else
    echo "✅ Modern Node version detected → Verdaccio 6 will be used"
    VERDACCIO_VERSION="6" # change be 6
fi

echo "📦 Selected Verdaccio version: $VERDACCIO_VERSION"


### ---------------------------
### 3. Install Verdaccio
### ---------------------------
echo "📦 Installing Verdaccio..."
pnpm -w add -D verdaccio@$VERDACCIO_VERSION

### ---------------------------
### 3.5 Initialize Verdaccio config
### ---------------------------
echo "🛢️ Running Verdaccio config init..."
bash "$SCRIPT_DIR/verdaccio/init.sh"

### ---------------------------
### 4. Start Verdaccio in background
### ---------------------------
if pgrep -f "verdaccio" > /dev/null; then
    echo "ℹ️ Verdaccio is already running"
else
    echo "▶️ Starting Verdaccio..."
    nohup pnpm verdaccio &>/dev/null &
    sleep 2
fi

echo "✅ Verdaccio is running"


### ---------------------------
### 5. Set registry to local Verdaccio
### ---------------------------
echo "🔁 Registry: NPM → Local Verdaccio"
bash "$SCRIPT_DIR/registry/set-local.sh"


### ---------------------------
### 6. Install workspace dependencies
### ---------------------------
echo "📦 Workspace install (apps + packages)"
pnpm install


### ---------------------------
### 7. Build packages
###    Order: config → ui → aggregator
### ---------------------------
echo "🛠️ 1/3 Building config packages..."
pnpm -w turbo run build --filter=packages/config/**

echo "🛠️ 2/3 Building UI packages..."
pnpm -w turbo run build --filter=packages/**

echo "🛠️ 3/3 Building Aggregator package..."
pnpm -w turbo run build --filter=@Galata/web-components


### ---------------------------
### 8. Husky installation
### ---------------------------
echo "🐶 Installing Husky..."

if ! grep -q "husky install" "$ROOT_DIR/package.json"; then
    pnpm husky install
else
    echo "ℹ️ Husky already configured in prepare"
    pnpm husky install
fi


### ---------------------------
### 9. Changeset initialize (idempotent)
### ---------------------------
echo "📝 Initializing Changeset..."

if [ -d "$ROOT_DIR/.changeset" ]; then
    echo "ℹ️ Changeset already exists, skipping init."
else
    # Install CLI if missing
    if [ ! -d "$ROOT_DIR/node_modules/@changesets" ]; then
        echo "📦 Installing @changesets/cli..."
        pnpm -w add -D @changesets/cli
    fi

    echo "🚀 Running changeset init..."
    pnpm changeset init
fi

### -------------------------------------------------------
### 10. Puppeteer Chrome Fix
### -------------------------------------------------------
echo "🧩 Checking Puppeteer Chromium..."

PUPPETEER_CACHE="$HOME/.cache/puppeteer"

if [ ! -d "$PUPPETEER_CACHE" ] || [ -z "$(ls -A "$PUPPETEER_CACHE" 2>/dev/null)" ]; then
    echo "📥 Chrome not found — installing for Puppeteer..."
    pnpm dlx puppeteer browsers install chrome
    echo "✅ Puppeteer Chrome installed"
else
    echo "ℹ️ Puppeteer cache found — skipping installation."
fi


### ---------------------------
### 11. Verify registry
### ---------------------------
echo "🔍 Verifying registry..."
bash "$SCRIPT_DIR/registry/verify-registry.sh"


echo "🎉 Galata Monorepo is ready!"
echo "To start development example:"
echo "pnpm dev --filter=apps/react"