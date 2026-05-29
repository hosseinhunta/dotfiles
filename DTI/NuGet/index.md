# Configuring NuGet Mirrors for .NET Packages in Iran 🇮🇷

When the official NuGet Gallery (`api.nuget.org`) becomes slow or inaccessible due to internet disruptions, switching to a locally hosted mirror inside Iran keeps your development and CI/CD pipelines running. This guide explains how to add and prioritise NuGet mirrors for the .NET CLI, Visual Studio, and manual `NuGet.config` files.

---

## 🗺️ Available NuGet Mirrors

| Mirror Provider | Service Index URL |
|-----------------|-------------------|
| **Chabokan**    | `https://mirror2.chabokan.net/nuget/v3/index.json` |
| **Liara**       | `https://package-mirror.liara.ir/repository/nuget/index.json` |
| **Hmirror**     | `https://repo.hmirror.ir/nuget/v3/index.json` |

> ℹ️ All URLs point to a NuGet v3 service index. If a provider gives only a base URL without `/v3/index.json`, append it manually; the official NuGet protocol requires the full service index path.

---

## 🛠️ Adding a Mirror Globally (all projects)

Use the `dotnet nuget` command to add a source at the user level.

```bash
# Add Chabokan mirror
dotnet nuget add source https://mirror2.chabokan.net/nuget/v3/index.json --name Chabokan

# Add Liara mirror
dotnet nuget add source https://package-mirror.liara.ir/repository/nuget/index.json --name Liara

# Add Hmirror
dotnet nuget add source https://repo.hmirror.ir/nuget/v3/index.json --name Hmirror
```

Once added, you need to **disable the official NuGet source** and **set the mirror as the primary source** if you want all restores to go through the mirror exclusively. Alternatively, you can keep the official source but lower its priority – see the section on priority below.

To disable the official `nuget.org` source:

```bash
dotnet nuget disable source nuget.org
```

To re‑enable later:

```bash
dotnet nuget enable source nuget.org
```

---

## 📁 Per‑Project or Solution Configuration

You can create a `NuGet.config` file in your project’s root (or solution directory) to define custom package sources that apply only to that project.

### Example `NuGet.config` (using Chabokan as primary)

```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <packageSources>
    <!-- Remove the default nuget.org source if desired -->
    <clear />
    <add key="Chabokan" value="https://mirror2.chabokan.net/nuget/v3/index.json" />
    <add key="Liara" value="https://package-mirror.liara.ir/repository/nuget/index.json" />
    <add key="Hmirror" value="https://repo.hmirror.ir/nuget/v3/index.json" />
    <!-- Fallback to official NuGet if needed -->
    <add key="nuget.org" value="https://api.nuget.org/v3/index.json" />
  </packageSources>
</configuration>
```

The `<clear />` tag removes all inherited sources (e.g., from global config). Then you can list your mirrors in the order you want them tried (first source listed gets highest priority). If you want the official NuGet to be a fallback only, place it at the end of the list.

### Managing Sources with CLI

Add a project‑level source (without `--global`):

```bash
dotnet nuget add source https://mirror2.chabokan.net/nuget/v3/index.json --name Chabokan --configfile NuGet.config
```

---

## ⚡ Priority & Fallback Behaviour

NuGet searches package sources in the order they appear in the configuration. The first source that contains the package is used. Therefore, to use the mirror as the **primary** source with an **automatic fallback** to the official gallery:

1. Put the mirror(s) at the top.
2. Keep the official `nuget.org` source enabled but at the bottom.

Example `NuGet.config`:

```xml
<configuration>
  <packageSources>
    <add key="Chabokan" value="https://mirror2.chabokan.net/nuget/v3/index.json" />
    <add key="Liara" value="https://package-mirror.liara.ir/repository/nuget/index.json" />
    <add key="nuget.org" value="https://api.nuget.org/v3/index.json" />
  </packageSources>
</configuration>
```

If the Chabokan mirror is unavailable, NuGet will automatically try Liara, and then the official gallery. This provides both speed and resilience.

---

## 🧪 Verifying the Mirror

To list all configured sources:

```bash
dotnet nuget list source
```

You should see your mirrors enabled. You can also test a restore:

```bash
dotnet restore --verbosity normal
```

Look for lines like `Using source https://mirror2.chabokan.net/nuget/v3/index.json` in the output.

---

## 🔁 Reverting to the Official NuGet Gallery

### Remove a specific mirror source

```bash
dotnet nuget remove source Chabokan
```

### Re‑enable the official source

```bash
dotnet nuget enable source nuget.org
```

### Or simply delete the project’s `NuGet.config`

If you used a per‑project config, removing the file will revert to the global settings.

---

## 🪟 Visual Studio Configuration

In Visual Studio, you can manage package sources via:

**Tools → NuGet Package Manager → Package Manager Settings → Package Sources**

Add the mirror URL (e.g., `https://mirror2.chabokan.net/nuget/v3/index.json`), give it a name, and use the arrows to move it to the top of the list for priority. Uncheck `nuget.org` if you want to disable the official source.

---

## 🐧 Linux / macOS note

The user‑level `NuGet.config` is located at:

- **Windows:** `%appdata%\NuGet\NuGet.Config`
- **Linux/macOS:** `~/.config/NuGet/NuGet.Config` or `~/.nuget/NuGet/NuGet.Config`

You can edit this file directly if you prefer manual control.