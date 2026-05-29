# Configuring Mirrors for JavaScript Package Managers in Iran 🇮🇷

When pulling packages from the default npm registry (`registry.npmjs.org`) is slow or impossible due to internet disruptions, switching to a local mirror solves the problem instantly. This guide shows how to set the Liara npm mirror for **npm**, **Yarn**, **pnpm**, and **Bun**.

> 🔗 **Mirror URL used in this guide:**  
> `https://package-mirror.liara.ir/repository/npm/`  
> (provided by Liara; other mirrors like ArvanCloud or Chabokan may offer similar services)

---

## 📦 npm

### Global configuration (applies to all projects for the current user)

```bash
npm config set registry https://package-mirror.liara.ir/repository/npm/ --global
```

### Per‑project configuration

Run this inside the project directory (creates/updates an `.npmrc` file):

```bash
npm config set registry https://package-mirror.liara.ir/repository/npm/
```

Or manually add to `.npmrc`:

```
registry=https://package-mirror.liara.ir/repository/npm/
```

### Verify the setting

```bash
npm config get registry
```

Should output the Liara mirror URL.

---

## 🧶 Yarn

### Yarn Classic (v1)

```bash
yarn config set registry https://package-mirror.liara.ir/repository/npm/
```

This updates the global Yarn configuration (usually `~/.yarnrc`).

### Yarn Berry (v2/v3/v4)

Yarn Berry does **not** have a global registry setting; it uses `.yarnrc.yml` per project.

Add this line to your project’s `.yarnrc.yml`:

```yaml
npmRegistryServer: "https://package-mirror.liara.ir/repository/npm/"
```

If the file doesn’t exist, create it at the root of your project. After changing the file, run:

```bash
yarn
```

to validate the new configuration.

### Verify (Yarn Classic)

```bash
yarn config get registry
```

For Yarn Berry, check the `.yarnrc.yml` file directly or run `yarn config get npmRegistryServer` (if the plugin `@yarnpkg/plugin-version` is not needed; otherwise just trust the file).

---

## 🧰 pnpm

### Global configuration

```bash
pnpm config set registry https://package-mirror.liara.ir/repository/npm/ --global
```

This writes to the global pnpm config (typically `~/.npmrc` or a pnpm‑specific file).

### Per‑project configuration

Inside the project:

```bash
pnpm config set registry https://package-mirror.liara.ir/repository/npm/
```

### Verify

```bash
pnpm config get registry
```

---

## 🥟 Bun

Bun stores its configuration in `~/.bunfig.toml`. You can set the registry using the Bun CLI:

```bash
bun config set registry https://package-mirror.liara.ir/repository/npm/
```

This command updates (or creates) `~/.bunfig.toml` with:

```toml
[install]
registry = "https://package-mirror.liara.ir/repository/npm/"
```

To verify, check the file or run:

```bash
bun config get registry
```

---

## 🧪 Testing the Mirror

After configuring any of these tools, try installing a small package to confirm the mirror works:

```bash
# For npm
npm install lodash

# For Yarn Classic / Berry
yarn add lodash

# For pnpm
pnpm add lodash

# For Bun
bun add lodash
```

The package should be downloaded quickly from the Liara mirror.

---

## 🔁 Reverting to the Default Registry

If you ever need to switch back to the official npm registry, use the following commands:

| Tool | Command |
|------|---------|
| npm | `npm config delete registry --global` or `npm config set registry https://registry.npmjs.org/` |
| Yarn Classic | `yarn config delete registry` |
| Yarn Berry | Remove or comment out `npmRegistryServer` in `.yarnrc.yml` |
| pnpm | `pnpm config delete registry` |
| Bun | `bun config delete registry` |
