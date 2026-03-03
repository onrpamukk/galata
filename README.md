# 📘 **Galata Monorepo — Developer Guide**

## Installation & Requirements

The Galata monorepo is structured for design system development, web component creation, and UI library distribution. All installation and runtime operations are managed through pnpm + turbo + changeset + verdaccio infrastructure.

---

## 🔧 Node Requirements

The Galata monorepo supports the following Node.js versions:

- **Node 20 and all later versions**

The installation behavior changes depending on the Node version:

### 🔹 Node **20+**

With these versions, installation is automatically performed with **Verdaccio 6**.

---

## 📦 Package Manager Requirement

Within the project:

### ✔️ The **pnpm + workspace** architecture is used.

Therefore:

- ❌ npm
- ❌ yarn
- ❌ bun

should **absolutely not be used**.

During the setup process, pnpm is installed automatically, but in case of any potential error, pnpm can be installed manually using:

```bash
npm i -g pnpm
```

After this step, installation can continue normally.

---

## 🔐 Verdaccio User Information

For Verdaccio, the local registry:

- user
- password
- email

values are located inside **scripts/verdaccio/init.sh**.

Since these credentials are **only needed for local development**, they do not pose any security risk.

---

## 🚀 Installation Steps

Only two commands are required for installation inside the Galata monorepo:

```bash
pnpm clean
pnpm l:setup
```

- For a clean installation, run **clean** first,
- Then execute **pnpm l:setup**.

These commands fully reset all components such as node_modules, dist, pnpm store, verdaccio config, and storage, and automatically start the setup process.

---

## 🔤 Script Naming Structure

Script naming inside the Galata monorepo uses meaningful prefixes:

### ✔️ `l:` prefix → **Local operations**

Examples:

- `pnpm l:setup`
- `pnpm l:dev`
- `pnpm l:build`

### ✔️ `v:` prefix → **Verdaccio operations**

Examples:

- `pnpm v:start`
- `pnpm v:stop`
- `pnpm v:reset`

---

## 🧪 Test Processes

For testing, the following commands can be executed:

```bash
pnpm test
pnpm test:coverage
pnpm test:debug
```

The recommended command is: **`test:debug`**
Because it provides a more helpful interface for both testing and debugging.

---

## 🎯 Summary

| Topic           | Description                              |
| --------------- | ---------------------------------------- |
| Node Version    | 20+ → Verdaccio 6 |
| Package Manager | pnpm only                                |
| Installation    | `pnpm clean` → `pnpm l:setup`            |
| Local Registry  | Verdaccio is installed automatically     |
| Script Prefixes | `l:` → local, `v:` → verdaccio           |
| Test            | `pnpm test:debug` recommended            |