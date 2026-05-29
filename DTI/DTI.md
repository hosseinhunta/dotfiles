# Developer Tools for Iran 🇮🇷

**Purpose:** Supporting the Iranian developer community with free, reliable tools — including GitLab, package mirrors, internet status radars, and essential development resources — especially during internet disruptions.

---

## 📡 Internet & Datacenter Status Radar

Live monitoring dashboards that show real-time connectivity, latency, and outage status of datacenters and services inside Iran.

- [**Parsico Radar**](https://radar.parsico.org/) — Broad internet health monitoring.
- [**ArvanCloud Radar**](https://radar.arvancloud.ir/) — Check connectivity between Iranian datacenters and global endpoints.
- [**Chabokan Radar**](https://radar.chabokan.net) — Advanced dashboard showing service-level and datacenter-level status.

---

## 🦊 GitLab — Iranian Hosted Instances

Fully-featured GitLab platforms hosted in Iranian datacenters, providing code management, CI/CD pipelines, issue tracking, and container registry — without relying on international connectivity.

- [**Chabokan GitLab**](https://gitlab.chabokan.net)
- [**Hamravesh GitLab (HamGit)**](https://hamgit.ir/)

### How to use:
1. Sign up at [gitlab.chabokan.net](https://gitlab.chabokan.net) or [hamgit.ir](https://hamgit.ir/).
2. Create a new project or import an existing repository.
3. Add the internal remote to your local repository:
   ```bash
   # For Chabokan GitLab
   git remote add chabokan https://gitlab.chabokan.net/username/project.git
   git push chabokan main

   # For HamGit
   git remote add hamgit https://hamgit.ir/username/project.git
   git push hamgit main
   ```
4. Use `.gitlab-ci.yml` to configure CI/CD, taking advantage of local runners and mirrors.

---

## 🔍 IP Lookup API

A free, no-authentication REST API to retrieve detailed IP information in JSON format — including ASN, ISP, geographical location, and carrier.

**Endpoint:** [https://chabokan.net/ip](https://chabokan.net/ip)

### Usage:
- Get your own IP info:
  ```bash
  curl https://chabokan.net/ip/
  ```
- Look up a specific IP:
  ```bash
  curl https://chabokan.net/ip/?address=1.1.1.1
  ```

> 🚀 **Benefits:** Instant, free, no rate limits, no API key needed.

---

## 🔌 Chabokan Whois — Chrome Extension

**Install from:** [Chrome Web Store](https://chromewebstore.google.com/detail/chabok-whois/ooknaaobajkeagaighenoofpimedplcl)

A browser extension that displays comprehensive domain and server intelligence for any website you visit:

- Domain registration details (registrar, creation/expiry dates)
- Owner information (name, organization, country)
- Server details (IP, ASN, ISP, geolocation)
- DNS records (A, MX, NS, TXT, etc.)
- SSL certificate chain & validity
- Detected technology stack

---

## 🌐 Chabokan Whois — Web Version

**URL:** [whois.chabokan.net](https://whois.chabokan.net)

The same powerful Whois tool accessible directly from any browser — no extension required. Perfect for mobile and desktop quick lookups. Just enter a domain name.

---

## 🧰 Essential Resources & Mirrors

A curated collection of internal services to keep development workflows running smoothly when international access is limited.

### DNS Resolvers (for bypassing filtering / improving resolution)
| Provider | Primary DNS | Secondary DNS | Info |
|---|---|---|---|
| Shecan | `178.22.122.100` | `185.51.200.2` | [shecan.ir](https://shecan.ir) |
| Infrastructure DNS | `217.218.127.127` | `217.218.155.155` | [tci.ir](https://www.tci.ir/) |
| Asiatek | `185.98.113.113` | `185.98.114.114` | [asiatech.ir](https://asiatech.ir/) |
| 0&1 | `45.9.252.80` | `45.9.253.53` | [0-1.ir](https://0-1.ir) |

### Monitoring & Speed Test
- [TestSpeed.ir](https://www.testspeed.ir/) — Internet speed test.
- [Hamravesh DC Monitor](https://dc.hamravesh.com) — Datacenter health dashboard.

### Package & Linux Mirrors
High‑speed, local mirrors for common Linux distributions, Docker images, and programming language registries.

| Mirror | URL |
|---|---|
|Dokcer| [Docker.md](./docker/index.md)|
|Linux| [Linux.md](./linux/index.md)|
|Python| [Python.md](./python/index.md)|
|NodeJs OR BunJs| [JS.md](./js/index.md)|
|Composer| [Composer.md](./php/index.md)|
|NuGet| [NuGet.md](./NuGet/index.md)|
|Maven| [java.md](./java/index.md)|
|GitHub Container Registry| [git.md](./git/index.md)|

### Developer Tools & Services

- **ArvanCloud Libraries (CDN)** — Common frontend libraries hosted locally: [lib.arvancloud.ir](https://lib.arvancloud.ir/libraries)
- **Official Documentation Mirrors** — Offline‑friendly docs for various languages: [thealibigdeli.ir/official-docs/](https://thealibigdeli.ir/official-docs/)
- **VS Code Extensions (offline pack)** — Curated list of essential extensions: [thealibigdeli.ir/vscode-extensions](https://thealibigdeli.ir/vscode-extensions)
- **Hamravesh Sentry** — Error tracking hosted in Iran: [sentry.hamravesh.com](https://sentry.hamravesh.com)
- **Ollama (Offline AI)** — Run large language models locally: [soft98.ir](https://soft98.ir/software/programming/16864-ollama.html)
- **Soft98** — Software download portal: [soft98.ir](https://soft98.ir)
- **DevNeeds** — Developer essentials marketplace: [devneeds.ir](https://devneeds.ir)
- **VS Code Online (DevNeeds)** — Browser‑based VS Code: [vscode.devneeds.ir](https://vscode.devneeds.ir/)
- **Mizito** — Iranian team communication platform (alternative to Slack/Teams): [mizito.ir](https://mizito.ir/)

---

With thanks to the **Chabokan, Liara, ArvanCloud, and Astel teams**
**In support of the Iranian developer community 🇮🇷**

**Built with ❤️ for Iranian developers**
