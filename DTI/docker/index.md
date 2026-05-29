# Setting Up Docker Hub Mirrors for Faster, More Reliable Pulls in Iran 🇮🇷

Docker Hub is the world's largest container image registry, but pulling images from it can be slow or even impossible when international internet connectivity is disrupted. **Registry mirrors** act as local caches, allowing you to pull images at high speed from servers inside Iran — without relying on unstable foreign links.

---

## 📋 Prerequisites

- **Docker Engine** installed on your system (Linux, Windows with WSL2, or macOS with Docker Desktop).  
  *Installation guide: [docs.docker.com/engine/install](https://docs.docker.com/engine/install/)*
- **Root or sudo privileges** to edit `/etc/docker/daemon.json` and restart the Docker service.
- A terminal session.

---

## 🧰 Available Docker Mirrors in Iran

Below is a list of active, reliable Docker registry mirrors hosted inside Iran. You can use any of them individually, or combine several for fallback.

| Mirror URL | Provider |
|---|---|
| `https://docker-mirror.liara.ir` | Liara |
| `https://hub.hamdocker.ir` | HamDocker |
| `https://docker.arvancloud.ir` | ArvanCloud |
| `https://mirrors.pardisco.co` | Pardisco |
| `https://docker.chrepo.ir` | Chrepo |
| `https://mirror2.chabokan.net` | Chabokan |

> ℹ️ **Note:** Most modern mirrors require HTTPS. If a URL is given as `hub.hamdocker.ir`, Docker will still attempt to connect via HTTPS by default, but it's safer to explicitly write `https://` in the configuration.

---

## 🛠️ Step‑by‑Step Configuration (Linux)

The configuration process is identical for all mirrors; we'll use Liara's mirror as the example.

### 1️⃣ Backup your current Docker daemon configuration
Before making any changes, create a backup of the existing `daemon.json` file. If it doesn't exist yet, the `cp` command will fail safely.

```bash
sudo cp /etc/docker/daemon.json /etc/docker/daemon.json.bak 2>/dev/null || true
```

### 2️⃣ Define the registry mirror
Add the mirror URL to the Docker daemon configuration. The following command overwrites the file with a single‑mirror setup:

```bash
sudo tee /etc/docker/daemon.json > /dev/null <<EOF
{
  "registry-mirrors": ["https://docker-mirror.liara.ir"]
}
EOF
```

> 💡 **Using multiple mirrors (recommended):**  
> You can list several mirrors inside the `"registry-mirrors"` array. Docker will try them in order, falling back to the next one if a mirror is unreachable. See the section below.

### 3️⃣ Reload systemd and restart Docker
Apply the new configuration:

```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
```

Wait a few seconds for Docker to start.

### 4️⃣ Verify the mirror is active
Check that the mirror appears in the Docker info:

```bash
docker info | grep -A5 "Registry Mirrors"
```

You should see output similar to:

```
Registry Mirrors:
  https://docker-mirror.liara.ir/
Live Restore Enabled: false
```

Now try pulling a small image to confirm the mirror is used:

```bash
docker pull hello-world
```

If the image is downloaded quickly (typically from the mirror cache), everything is working.

---

## 🧩 Adding Multiple Mirrors for Fallback

Reliability improves when you define several mirrors. Edit `daemon.json` like this:

```bash
sudo tee /etc/docker/daemon.json > /dev/null <<EOF
{
  "registry-mirrors": [
    "https://docker-mirror.liara.ir",
    "https://docker.arvancloud.ir",
    "https://mirror2.chabokan.net",
    "https://hub.hamdocker.ir",
    "https://mirrors.pardisco.co",
    "https://docker.chrepo.ir"
  ]
}
EOF
```

After updating, always restart Docker:

```bash
sudo systemctl restart docker
```

Docker will try the mirrors in the order listed. If the first one fails, it automatically falls back to the next.

---

## 🔍 Troubleshooting

### ❌ `docker info` shows no mirror
- Make sure you restarted Docker after editing `daemon.json`.
- Validate the JSON syntax: `cat /etc/docker/daemon.json | python3 -m json.tool` (if Python is available) or use `jq '.' /etc/docker/daemon.json`.
- Check the Docker daemon logs: `sudo journalctl -u docker --no-pager -n 50`.

### ❌ "cannot connect to Docker daemon"
- Ensure the Docker service is running: `sudo systemctl status docker`.
- If it fails to start, look for error messages about invalid JSON in `/etc/docker/daemon.json`. Common mistake: missing quotes or trailing commas.
- Use the backup file to restore the previous configuration: `sudo cp /etc/docker/daemon.json.bak /etc/docker/daemon.json` then restart Docker.

### ❌ Pulls are still slow or timing out
- The mirror might be temporarily unavailable. Switch the order of mirrors or test each mirror manually by trying to reach it via `curl https://mirror-url/v2/`.
- Some corporate or ISP firewalls may block certain mirrors. Try a different mirror from the list.
- Docker Desktop (macOS/Windows) users: The `daemon.json` file location is different. Use the Docker Desktop settings UI to add mirrors under **Docker Engine** configuration.

### ❌ HTTP mirrors (without `https://`)
- Docker expects mirrors to be HTTPS by default. If you must use an HTTP‑only mirror (rare), you need to configure `"insecure-registries"` – but this is **not recommended** for security reasons. Prefer HTTPS mirrors.

---

## ✅ Wrapping Up

You've successfully configured Docker to use high‑speed, locally hosted registry mirrors. This dramatically improves pull times and keeps your development and deployment pipelines running smoothly, even during international connectivity issues.

> **Pro tip:** Bookmark this guide and share it with your fellow developers. The list of mirrors is regularly updated; check back for new entries.

