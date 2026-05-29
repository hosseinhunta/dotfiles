# Configuring PyPI Mirrors for Python Packages in Iran 🇮🇷

When the official Python Package Index (`pypi.org`) becomes slow or unreachable due to internet disruptions, switching to a local mirror keeps your workflows running. This guide covers how to configure popular Python package managers to use a mirror hosted inside Iran.

---

## 🗺️ Available PyPI Mirrors

| Mirror Provider | Base URL | `pip` Index URL |
|-----------------|----------|-----------------|
| **Chabokan** | `https://mirror2.chabokan.net/pypi` | `https://mirror2.chabokan.net/pypi/simple/` |
| **Liara** | `https://package-mirror.liara.ir/repository/pypi` | `https://package-mirror.liara.ir/repository/pypi/simple/` |
| **Hmirror** | `https://repo.hmirror.ir/python` | `https://repo.hmirror.ir/python/simple/` |

> ℹ️ For `pip` and most tools, the index URL **must** end with `/simple/` to comply with the PEP 503 Simple Repository API. If you use the base URL and encounter errors, append `/simple/`.

In the following commands, replace `<MIRROR>` with one of the index URLs above.

---

## 🐍 pip

### Set globally (applies to all projects for the current user)

```bash
pip config set global.index-url https://mirror2.chabokan.net/pypi/simple/
```

or use any mirror:

```bash
pip config set global.index-url https://package-mirror.liara.ir/repository/pypi/simple/
```

### Per‑project configuration

You can create a `pip.conf` (or `pip.ini` on Windows) inside your project directory, or use an environment variable:

```bash
export PIP_INDEX_URL=https://mirror2.chabokan.net/pypi/simple/
```

### Verify the setting

```bash
pip config list
```

or

```bash
python -m pip config list
```

---

## 🎼 Pipenv

Pipenv respects the `PIP_INDEX_URL` environment variable, or you can specify the mirror inside the `Pipfile`:

### Option 1 – Environment variable (recommended)

```bash
export PIP_INDEX_URL=https://mirror2.chabokan.net/pypi/simple/
pipenv install requests
```

### Option 2 – Edit `Pipfile`

Add a `[[source]]` block at the top of your `Pipfile`:

```toml
[[source]]
url = "https://mirror2.chabokan.net/pypi/simple/"
verify_ssl = true
name = "chabokan"
```

If you want this source to be the **default**, set `verify_ssl` as needed and make sure it’s the first source listed. You may remove the original `pypi` entry.

---

## 📜 Poetry

### Option 1 – Configure as the default source

```bash
poetry config repositories.chabokan https://mirror2.chabokan.net/pypi/simple/
poetry config http-basic.chabokan "" ""
```

Then modify `pyproject.toml` to use this source as default:

```toml
[[tool.poetry.source]]
name = "chabokan"
url = "https://mirror2.chabokan.net/pypi/simple/"
priority = "default"
```

Remove any other source with `priority = "default"` to avoid conflicts.

### Option 2 – Per‑dependency source (if you only want some packages from the mirror)

```toml
[[tool.poetry.source]]
name = "chabokan"
url = "https://mirror2.chabokan.net/pypi/simple/"
priority = "explicit"
```

Then when adding a package, use:

```bash
poetry add requests --source chabokan
```

---

## 🧱 PDM

Set the mirror globally:

```bash
pdm config pypi.url https://mirror2.chabokan.net/pypi/simple/
```

Or in the project’s `pyproject.toml`:

```toml
[[tool.pdm.source]]
name = "chabokan"
url = "https://mirror2.chabokan.net/pypi/simple/"
verify_ssl = true
```

Then set it as the default:

```toml
[tool.pdm.resolution]
allow-prereleases = false
; (other settings)
default-source = "chabokan"
```

---

## ⚡ uv

`uv` uses the same `PIP_INDEX_URL` environment variable, or the `--index-url` flag:

```bash
# Environment variable
export UV_DEFAULT_INDEX=https://mirror2.chabokan.net/pypi/simple/
uv pip install requests

# Command-line flag
uv pip install --index-url https://mirror2.chabokan.net/pypi/simple/ requests
```

---

## 🧪 Verifying the Mirror

Install a small package to test:

```bash
pip install colorama
```

You should see the download coming from your chosen mirror (e.g., `Downloading … from mirror2.chabokan.net`).

---

## 🔁 Reverting to the Official PyPI

If you need to go back to `pypi.org`, simply remove or reset the configuration.

| Tool | Command / Action |
|------|------------------|
| pip | `pip config unset global.index-url` or set to `https://pypi.org/simple/` |
| Pipenv | Unset `PIP_INDEX_URL` or remove mirror `[[source]]` from `Pipfile` |
| Poetry | Remove the custom source or set `priority = "default"` back to the official PyPI source |
| PDM | `pdm config del pypi.url` or change `default-source` in `pyproject.toml` |
| uv | Unset `UV_DEFAULT_INDEX` or stop using `--index-url` flag |