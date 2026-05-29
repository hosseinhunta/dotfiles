# Configuring Local Mirrors for Linux Package Repositories in Iran 🇮🇷

When internet connectivity is unstable or access to international servers is restricted, using locally hosted package mirrors can dramatically improve download speeds and reliability. This guide covers how to configure the best mirrors available in Iran for **Debian**, **Ubuntu**, and **CentOS**.

All mirrors listed here are maintained by Iranian cloud and hosting providers, optimized for low latency within the country.

---

## 🗺️ Available Mirrors – Quick Reference

### For Debian & Ubuntu (APT)

| Mirror Provider | Base URL | Paths / Notes |
|-----------------|----------|---------------|
| **Liara** | `http://linux-mirror.liara.ir/repository` | `debian/` `debian-security/` `ubuntu/` `ubuntu-security/` |
| **Chabokan** | `https://mirror2.chabokan.net` | `debian/` `ubuntu/` |
| **ArvanCloud** | `http://mirror.arvancloud.ir` | `debian/` `debian-security/` `ubuntu/` |
| **Chrepo** | `https://debian.chrepo.ir` (Debian)  `https://ubuntu.chrepo.ir` (Ubuntu) | Direct distro paths |
| **Pardisco** | `https://mirrors.pardisco.co` | `debian/` `debian-security/` `ubuntu/` `ubuntu-security/` |

### For CentOS (YUM/DNF)

| Mirror Provider | Base URL | Notes |
|-----------------|----------|-------|
| **Liara** | `http://linux-mirror.liara.ir/repository/centos/` | Use standard repo structure (`$releasever/...`) |
| **ArvanCloud** | `http://mirror.arvancloud.ir/centos/` or `http://mirror.arvancloud.ir/$contentdir/...` | Both classic and modular layout |

---

## 🐧 Debian

The following steps will replace the official Debian repositories with local mirrors.  
*The examples use **Debian 12 (Bookworm)**; replace `bookworm` with your release codename (`bullseye`, `trixie`, etc.) if needed.*

### 1. Backup current configuration

```bash
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
```

### 2. Edit sources.list

Open the file with your preferred text editor:

```bash
sudo nano /etc/apt/sources.list
```

Clear the file and replace its content with one of the mirror sets below.

#### Option A – Liara mirror (recommended)

```
deb http://linux-mirror.liara.ir/repository/debian bookworm main non-free-firmware
deb-src http://linux-mirror.liara.ir/repository/debian bookworm main non-free-firmware

deb http://linux-mirror.liara.ir/repository/debian-security bookworm-security main non-free-firmware
deb-src http://linux-mirror.liara.ir/repository/debian-security bookworm-security main non-free-firmware

deb http://linux-mirror.liara.ir/repository/debian bookworm-updates main non-free-firmware
deb-src http://linux-mirror.liara.ir/repository/debian bookworm-updates main non-free-firmware
```

#### Option B – Chabokan mirror

```
deb [trusted=yes] https://mirror2.chabokan.net/debian bookworm main contrib non-free
deb [trusted=yes] https://mirror2.chabokan.net/debian bookworm-updates main contrib non-free
deb [trusted=yes] https://mirror2.chabokan.net/debian bookworm-security main contrib non-free
```

> ⚠️ `[trusted=yes]` disables GPG signature verification. For a secure setup, consider installing the repo’s GPG key instead.

#### Option C – ArvanCloud mirror

```
deb http://mirror.arvancloud.ir/debian bookworm main
deb http://mirror.arvancloud.ir/debian-security bookworm-security main
```

#### Option D – Chrepo mirror

```
deb https://debian.chrepo.ir bookworm main
deb https://debian.chrepo.ir bookworm-security main
```

#### Option E – Pardisco mirror

```
deb https://mirrors.pardisco.co/debian bookworm main contrib non-free
deb https://mirrors.pardisco.co/debian-security bookworm-security main contrib non-free
deb https://mirrors.pardisco.co/debian bookworm-updates main contrib non-free
```

### 3. Apply changes

Save the file and exit, then update the package index:

```bash
sudo apt update
```

Your Debian system will now pull packages from the selected Iranian mirror.

---

## 🟤 Ubuntu

The procedure is identical to Debian, but the repository paths and codenames differ.  
*The examples use **Ubuntu 20.04 (Focal)**; replace `focal` with your release (`jammy`, `noble`, etc.).*

### 1. Backup

```bash
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
```

### 2. Edit sources.list

```bash
sudo nano /etc/apt/sources.list
```

Replace the content with one of the following sets.

#### Option A – Liara mirror

```
deb http://linux-mirror.liara.ir/repository/ubuntu focal main
deb-src http://linux-mirror.liara.ir/repository/ubuntu focal main

deb http://linux-mirror.liara.ir/repository/ubuntu-security focal-security main
deb-src http://linux-mirror.liara.ir/repository/ubuntu-security focal-security main

deb http://linux-mirror.liara.ir/repository/ubuntu focal-updates main
deb-src http://linux-mirror.liara.ir/repository/ubuntu focal-updates main
```

#### Option B – Chabokan mirror

```
deb [trusted=yes] https://mirror2.chabokan.net/ubuntu focal main universe
deb [trusted=yes] https://mirror2.chabokan.net/ubuntu focal-updates main universe
deb [trusted=yes] https://mirror2.chabokan.net/ubuntu focal-security main universe
```

#### Option C – ArvanCloud mirror

```
deb http://mirror.arvancloud.ir/ubuntu focal universe
```

#### Option D – Chrepo mirror

```
deb https://ubuntu.chrepo.ir focal main
```

#### Option E – Pardisco mirror

```
deb https://mirrors.pardisco.co/ubuntu focal main restricted universe multiverse
deb https://mirrors.pardisco.co/ubuntu-security focal-security main restricted universe multiverse
deb https://mirrors.pardisco.co/ubuntu focal-updates main restricted universe multiverse
```

### 3. Update package list

```bash
sudo apt update
```

---

## 🎛️ CentOS

CentOS uses YUM/DNF with `.repo` files stored in `/etc/yum.repos.d/`.  
The following instructions create a new repository file that points to a local mirror.  
*Adjust `$releasever` – it will be automatically replaced by your system’s version (e.g., `7`, `8`, `9`).*

### 1. Backup existing repos (optional)

```bash
sudo mkdir -p /etc/yum.repos.d/backup
sudo cp /etc/yum.repos.d/*.repo /etc/yum.repos.d/backup/
```

### 2. Create a new mirror configuration

Create a file, for example `/etc/yum.repos.d/iran-mirror.repo`:

```bash
sudo nano /etc/yum.repos.d/iran-mirror.repo
```

Insert **one** of the following blocks (you can also enable multiple repos by giving them unique `[name]` identifiers).

#### Option A – Liara mirror

```ini
[liara-base]
name=CentOS-$releasever - Base (Liara)
baseurl=http://linux-mirror.liara.ir/repository/centos/$releasever/os/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever
enabled=1

[liara-updates]
name=CentOS-$releasever - Updates (Liara)
baseurl=http://linux-mirror.liara.ir/repository/centos/$releasever/updates/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever
enabled=1
```

> ℹ️ The GPG key file name varies across CentOS versions; you may need to download it first if it’s not present.

#### Option B – ArvanCloud mirror (classic CentOS layout)

```ini
[arvancloud-base]
name=CentOS-$releasever - Base (ArvanCloud)
baseurl=http://mirror.arvancloud.ir/centos/$releasever/os/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever
enabled=1
```

For CentOS 8+ with modular streams, you may also need an AppStream repo:

```ini
[arvancloud-appstream]
name=CentOS-$releasever - AppStream (ArvanCloud)
baseurl=http://mirror.arvancloud.ir/centos/$releasever/AppStream/$basearch/os/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever
enabled=1
```

Alternatively, you can use the `$contentdir` variable:

```ini
[arvancloud-base-modular]
name=CentOS-$releasever - Base (ArvanCloud Modular)
baseurl=http://mirror.arvancloud.ir/$contentdir/$releasever/BaseOS/$basearch/os/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever
enabled=1
```

### 3. Clean and update

```bash
sudo dnf clean all          # or sudo yum clean all
sudo dnf makecache          # sudo yum makecache
```

Now your CentOS system will fetch packages from the selected Iranian mirror.

---

## 🔁 Switching Between Mirrors

If a mirror becomes unavailable, simply edit the appropriate configuration file (`sources.list` or `.repo` file), replace the URLs with another mirror from the lists above, and run the update command again.

**Debian/Ubuntu:**
```bash
sudo apt update
```

**CentOS:**
```bash
sudo dnf clean all && sudo dnf makecache
```
