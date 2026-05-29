# Installing ionCube Loader on WSL Debian

This guide walks you through the manual installation of the ionCube Loader on a Debian server. The ionCube Loader is required to run encoded PHP files from many commercial scripts.

## Prerequisites

- A Debian server (with root or sudo access)
- PHP already installed (version 7.4 – 8.4; note that ionCube does **not** officially support PHP 8.3 or higher as of July 2025)
- Ability to restart your web server or PHP-FPM service

## Step 1 – Identify Your PHP Version and System Architecture

Run the following commands to determine your PHP version and CPU architecture:

```bash
php -v
# Example output: PHP 8.4.* (cli)

uname -m
# x86_64 → 64-bit Intel/AMD
# aarch64 → ARM64 (e.g., AWS Graviton)
```

## Step 2 – Download the ionCube Loaders

Go to the official ionCube download page or use `wget` directly.

For **x86_64** (most common):
```bash
cd /tmp
wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
```
Extract the archive:
```bash
tar xzf ioncube_loaders_lin_x86-64.tar.gz
```

## Step 3 – Find PHP’s Extension Directory

```bash
php -i | grep extension_dir
# Example output: extension_dir => /usr/lib/php/20240812 => /usr/lib/php/20240812
```

Take note of the path (e.g., `/usr/lib/php/20240812`). This is where the loader file must be placed.

## Step 4 – Copy the Correct Loader File

Inside the extracted `ioncube` folder, you will see many files named `ioncube_loader_lin_<phpversion>.so`. Choose the one matching your PHP version.

For PHP 8.4:
```bash
sudo cp /tmp/ioncube/ioncube_loader_lin_8.4.so /usr/lib/php/20240812/
```

Adjust the source file name and destination directory to match your environment.

## Step 5 – Configure php.ini

You need to add the `zend_extension` directive to your PHP configuration. The correct `php.ini` file depends on your web server setup.

- **Apache (mod_php)**: `/etc/php/<phpversion>/apache2/php.ini`
- **Nginx + PHP-FPM**: `/etc/php/<phpversion>/fpm/php.ini`
- **CLI (optional)**: `/etc/php/<phpversion>/cli/php.ini`

Open the appropriate file with nano (or your preferred editor):
```bash
sudo nano /etc/php/8.4/cli/php.ini   # example for PHP-CLI
```

Add the following line at the end (use the full path to the `.so` file):
```ini
zend_extension = "/usr/lib/php/20240812/ioncube_loader_lin_8.4.so"
```

Save and exit.

## Step 6 – Restart PHP Service

- If using **PHP-FPM**:
  ```bash
  sudo systemctl restart php8.4-fpm
  ```
- If using **Apache**:
  ```bash
  sudo systemctl restart apache2
  ```

## Step 7 – Verify Installation

Check that ionCube is loaded:

```bash
php -m | grep ionCube
# Should output: ionCube

php -v | grep ionCube
# Should show: with the ionCube PHP Loader
```

You can also create a simple PHP info file:
```bash
echo "<?php phpinfo(); ?>" | php -d display_errors=1 | grep ionCube
```

## Troubleshooting

- **"Unable to load dynamic library"** – Make sure the path in `php.ini` is correct and that the `.so` file exists in that location.
- **Loader not loaded after restart** – Check your PHP-FPM or Apache error logs:
  ```bash
  sudo tail -f /var/log/php8.4-fpm.log
  sudo tail -f /var/log/apache2/error.log
  ```
- **ionCube not compatible with PHP 8.3/8.4** – You must downgrade to PHP 8.4 or wait for an updated loader from ionCube.

## Important Notes

- Do **not** use the CLI `php.ini` for web requests unless you specifically need the loader for command line scripts.
- If you have multiple PHP versions installed, repeat the process for each version you intend to use ionCube with.
- The ionCube Loader is a **Zend extension**, so it must be added using `zend_extension`, not `extension`.

## Uninstalling ionCube

To remove ionCube, simply comment out or delete the `zend_extension` line from your `php.ini` files and restart your web server/PHP-FPM. Then delete the `.so` file from the extension directory.

```bash
sudo rm /usr/lib/php/*/ioncube_loader_lin_8.4.so
```