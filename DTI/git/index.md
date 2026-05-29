# Configuring Mirrors for GitHub Container Registry (ghcr.io) in Iran 🇮🇷

The GitHub Container Registry (`ghcr.io`) hosts a vast number of container images. When direct access is slow or blocked, using a locally‑hosted mirror inside Iran ensures reliable pulls. Liara provides a dedicated pull‑through cache for ghcr.io that you can use transparently.

---

## ❗ Important: ghcr.io Mirrors Are Not Docker Hub Mirrors

Docker’s `registry-mirrors` setting in `daemon.json` traditionally **only applies to Docker Hub** (`docker.io`). Adding a URL like `https://ghcr-mirror.liara.ir` to a flat list will not mirror ghcr.io – Docker will ignore it for images pulled from `ghcr.io`.

**From Docker Engine 23.0 onward**, you can configure **per‑registry mirrors** by specifying the registry hostname as a key. This guide shows you how to use that feature, as well as a fallback method for older Docker versions.

---

## 🗺️ Available ghcr.io Mirror

| Mirror Provider | URL | Notes |
|-----------------|-----|-------|
| **Liara** | `https://ghcr-mirror.liara.ir` | Pull‑through cache for `ghcr.io` |

> ℹ️ If other Iranian providers offer ghcr.io mirrors, you can add them using the same syntax shown below.

---

## ✅ Prerequisites

- **Docker Engine ≥ 23.0** (for per‑registry mirror support)  
  Check your version: `docker --version`
- Root or sudo access to edit `/etc/docker/daemon.json` and restart Docker.

---

## 🛠️ Method 1: Per‑Registry Mirror (Docker ≥ 23.0)

### 1. Backup current daemon configuration

```bash
sudo cp /etc/docker/daemon.json /etc/docker/daemon.json.bak 2>/dev/null || true
```

### 2. Edit `daemon.json` to add the ghcr.io mirror

Open the file with superuser privileges:

```bash
sudo nano /etc/docker/daemon.json
```

Add the following structure. If you already have other Docker Hub mirrors under the `"registry-mirrors"` key, you must convert the configuration to the new per‑registry format.

#### Example: Only ghcr.io mirror (no Docker Hub mirrors)

```json
{
  "registry-mirrors": {
    "https://ghcr.io": ["https://ghcr-mirror.liara.ir"]
  }
}
```

#### Example: Both Docker Hub mirrors and ghcr.io mirror

```json
{
  "registry-mirrors": {
    "https://docker.io": ["https://docker-mirror.liara.ir", "https://mirror2.chabokan.net"],
    "https://ghcr.io": ["https://ghcr-mirror.liara.ir"]
  }
}
```

> ⚠️ **Note:** In this format, the value of each registry key is a **list** of mirrors (URL strings). The order matters – Docker tries them sequentially.

Save the file and exit.

### 3. Reload and restart Docker

```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
```

### 4. Verify the mirror is active

Check that Docker lists the mirror for ghcr.io:

```bash
docker info | grep -A10 "Registry Mirrors"
```

You should see output similar to:

```
Registry Mirrors:
 https://ghcr.io:
  https://ghcr-mirror.liara.ir/
```

Now test by pulling an image from ghcr.io:

```bash
docker pull ghcr.io/n8n-io/n8n:latest
```

The pull should be fast and originate from the mirror.

---

## 🧪 Method 2: Fallback for Older Docker Versions (Pull‑Through Cache)

If you cannot upgrade to Docker 23+, you can set up a **local pull‑through cache** that proxies ghcr.io. This requires running a separate registry container that fetches from the mirror.

### Step 1: Run a local registry that uses Liara’s mirror as upstream

```bash
docker run -d \
  --name ghcr-cache \
  --restart always \
  -p 5000:5000 \
  -e REGISTRY_PROXY_REMOTEURL=https://ghcr-mirror.liara.ir \
  registry:2
```

Now you have a local registry at `localhost:5000` that proxies Liara’s ghcr mirror.

### Step 2: Configure Docker to use this local proxy as a mirror for ghcr.io

Edit `/etc/docker/daemon.json`:

```json
{
  "registry-mirrors": {
    "https://ghcr.io": ["http://localhost:5000"]
  }
}
```

Restart Docker:

```bash
sudo systemctl restart docker
```

### Step 3: Verify

```bash
docker info | grep -A10 "Registry Mirrors"
docker pull ghcr.io/n8n-io/n8n:latest
```

The local proxy will forward requests to Liara’s mirror. This method works on any Docker version.

---

## 🔁 Switching or Removing the ghcr.io Mirror

To use another mirror URL, simply replace the URL in `daemon.json` and restart Docker.

To remove the ghcr.io mirror entirely, delete the `"https://ghcr.io"` key from the configuration.

```bash
sudo systemctl restart docker
```

---

## ❓ Troubleshooting

### The mirror does not appear in `docker info`
- Confirm you are using Docker ≥ 23.0 if using Method 1.
- Make sure the JSON is valid (`python3 -m json.tool /etc/docker/daemon.json` or `jq .`).
- Check Docker daemon logs: `sudo journalctl -u docker --no-pager -n 30`.

### Pulls are still slow or timing out
- The mirror might be temporarily unavailable. Try pulling the image directly from `ghcr-mirror.liara.ir` (with a proper repo name) to see if the service is up.
- If you must use the direct mirror URL for pulling, you can pull with the mirror domain and then retag:
  ```bash
  docker pull ghcr-mirror.liara.ir/n8n-io/n8n:latest
  docker tag ghcr-mirror.liara.ir/n8n-io/n8n:latest ghcr.io/n8n-io/n8n:latest
  ```
  This bypasses Docker’s mirror logic but guarantees you use the mirror.