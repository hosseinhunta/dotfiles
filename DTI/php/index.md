# Configuring Composer Mirrors for PHP Packages in Iran 🇮🇷

When the default Composer repository (`repo.packagist.org`) becomes slow, unreliable, or completely inaccessible due to internet disruptions, switching to a local mirror ensures that your dependencies can still be installed and updated. This guide shows how to set up Composer to use high‑speed mirrors hosted inside Iran.

---

## 🗺️ Available Composer Mirrors

| Mirror Provider | URL (composer repository) |
|-----------------|---------------------------|
| **Chabokan**    | `https://mirror2.chabokan.net/composer/` |
| **Liara**       | `https://package-mirror.liara.ir/repository/composer/` |

> ℹ️ These mirrors act as transparent proxies to the official Packagist. All package metadata and zip files are served from the mirror, drastically reducing download time and bypassing international connectivity issues.

---

## 🎵 Setting the Mirror Globally (all projects)

Run this command to replace the default Packagist URL with your chosen mirror:

```bash
composer config -g repo.packagist composer https://mirror2.chabokan.net/composer/
```

To use the Liara mirror instead:

```bash
composer config -g repo.packagist composer https://package-mirror.liara.ir/repository/composer/
```

This writes the configuration to `~/.config/composer/config.json` (or `%APPDATA%/Composer/config.json` on Windows). All `composer install` and `composer require` commands will now use the mirror.

---

## 📁 Per‑Project Mirror (no global changes)

If you prefer to use a mirror only for a specific project, run the same command **without** the `-g` flag inside the project directory:

```bash
cd your-project/
composer config repo.packagist composer https://mirror2.chabokan.net/composer/
```

This updates the project’s `composer.json` with a `repositories` entry:

```json
{
    "repositories": {
        "packagist": {
            "type": "composer",
            "url": "https://mirror2.chabokan.net/composer/"
        }
    }
}
```

Any other developer cloning the project will also use this mirror automatically.

---

## 🧪 Verifying the Mirror

To confirm the mirror is active, check the Composer configuration:

```bash
composer config -g repo.packagist
```

Or, for a per-project setup:

```bash
composer config repo.packagist
```

You should see the mirror URL listed as the repository URL. Then, try installing a package to see it in action:

```bash
composer require psr/log
```

Watch the output – the download should originate from your mirror domain (e.g., `mirror2.chabokan.net`).

---

## 🔁 Switching Between Mirrors (or Back to Official Packagist)

You can freely change the mirror URL at any time.

**To switch to a different mirror:**
```bash
composer config -g repo.packagist composer https://package-mirror.liara.ir/repository/composer/
```

**To revert to the official Packagist:**
```bash
composer config -g repo.packagist composer https://repo.packagist.org
```

For per-project, drop the `-g` flag and run inside the project directory.

---

## 🧰 Bonus: Using Multiple Mirrors as Fallback

Composer does not natively support multiple repository URLs for the same package source. If you need fallback, you can add the mirror as an additional repository with a different name, but the default `packagist` will still be used unless disabled. A more robust approach is to use a proxy or just switch manually when a mirror is down.