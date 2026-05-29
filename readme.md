# 🚀 My Developer Dotfiles

A fully automated development environment setup for Windows.  
This repository contains all my configurations for **PowerShell**, **Oh My Posh**, **VS Code profiles**, **extensions**, and **fonts** – ready to be deployed on any fresh Windows machine with a single script.

## ✨ What’s Inside?

- **PowerShell 7** – modern, cross‑platform shell.
- **Oh My Posh** – beautiful, customisable prompt with a custom theme.
- **PSReadLine** – intelligent auto‑suggestions and history search (configured inside the PowerShell profile).
- **VS Code** – fully isolated language profiles for PHP, Python, and TypeScript/JavaScript, each with its own extensions and settings.
- **Nerd Fonts** – ligature‑rich coding fonts (manual installation required).
- **Terminal look & feel** – smooth scrolling, cursor animations, minimal UI.


## 🇮🇷 Developer Tools for Iran (DTI)

A curated set of locally‑hosted mirrors and tools to help Iranian developers overcome internet disruptions. Includes setup guides for Docker, Linux (Debian/Ubuntu/CentOS), NPM/Yarn/PNPM/Bun, Python (pip/Poetry/uv), PHP Composer, NuGet, GitHub Container Registry, Maven, GitLab, and more.

📖 [View the full DTI guide →](./DTI/DTI.md)

---

## 📋 Prerequisites

- **Windows 10/11** (fresh installation is totally fine).
- **Git** installed ([git-scm.com](https://git-scm.com/)).
- **PowerShell 7** – the script will install it automatically if missing, but you can pre‑install it from the Microsoft Store.
- **Administrator privileges** – needed only to run the setup script (for `winget` installations).

## 🛠️ Installation (How to Use)

1. **Clone the repository** anywhere you like:
   ```powershell
   git clone https://github.com/your-username/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Run the setup script as Administrator**:
   - Right‑click PowerShell 7 and select *Run as Administrator*, then navigate to the dotfiles folder and execute:
     ```powershell
     Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass  # only if execution policy is restricted
     ./setup.ps1
     ```

3. **Install the required Nerd Font manually**:
   - Open the `fonts/README.md` file, follow the link(s), download the font, and install it (right‑click → Install).
   - The script will remind you about this step.

4. **Restart PowerShell and VS Code**.
   - Everything should look and feel exactly the way you like it.

## 📦 Installing Chocolatey

[Chocolatey](https://chocolatey.org) is a package manager for Windows that simplifies installing, updating, and managing software from the command line. It’s especially useful for setting up development tools and dependencies quickly.

### Prerequisites

-   You must have **PowerShell** (or Command Prompt) opened as Administrator.
-   Ensure that your execution policy is not blocking scripts (see step 1 below).

### Installation Steps

1.  **Open PowerShell as Administrator** (right‑click on PowerShell and select *Run as Administrator*).

2.  **Check your current execution policy** by running:
    ```powershell
    Get-ExecutionPolicy
    ```
    If it returns `Restricted`, you need to bypass it temporarily for the installation.

3.  **Run the official Chocolatey installation command** (this sets the execution policy for the current process, configures security protocols, and downloads the install script from the Chocolatey website):
    ```powershell
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    ```

    > **Note:** The script will automatically download and install the required .NET Framework if it’s missing, and set up the Chocolatey CLI for you.

4.  Wait a few seconds for the installation to complete. Once done, you can verify that Chocolatey is installed by running:
    ```powershell
    choco --version
    ```

### Using Chocolatey

After installation, you can install packages by running:
```powershell
choco install <package-name>
```

To upgrade all installed packages:
```powershell
choco upgrade all
```

For more details, visit the [official Chocolatey documentation](https://docs.chocolatey.org).


## 🖥️ Installing Windows Terminal via Chocolatey

[Windows Terminal](https://github.com/microsoft/terminal) is a modern, fast, and feature‑rich terminal application for command‑line users. It supports multiple tabs, panes, GPU‑accelerated text rendering, and full customization.

### Installation via Chocolatey (Unofficial)

If you already have Chocolatey installed (see previous section), you can install Windows Terminal with a single command.

1.  **Open PowerShell or Command Prompt as Administrator**.

2.  **Run the following command** to install the `microsoft-windows-terminal` package:
    ```powershell
    choco install microsoft-windows-terminal
    ```

3.  **Wait for the installation to finish**. Chocolatey will download the latest stable release from Microsoft and install it on your system.

### Upgrading Windows Terminal

To keep Windows Terminal up to date, run:
```powershell
choco upgrade microsoft-windows-terminal
```

### Alternative Installation Methods (for reference)

-   **Microsoft Store (recommended for automatic updates)**:  
    Install directly from the [Microsoft Store](https://aka.ms/terminal).
-   **GitHub releases**:  
    Download the latest `.msixbundle` from the [releases page](https://github.com/microsoft/terminal/releases) and double‑click to install.
-   **winget (Windows Package Manager)**:  
    ```powershell
    winget install --id=Microsoft.WindowsTerminal -e
    ```

For more details, visit the [Windows Terminal GitHub repository](https://github.com/microsoft/terminal).

## 🐧 Installing Windows Subsystem for Linux (WSL)

Windows Subsystem for Linux (WSL) allows you to run native Linux command‑line tools and applications directly on Windows, without the overhead of a virtual machine or dual‑boot setup. It’s perfect for developers who need access to Linux tools like `grep`, `awk`, `sed`, or even full IDEs and containers.

### Prerequisites

-   You must be running **Windows 10 version 2004 or higher** (Build 19041 or later) or **Windows 11**.
-   You need **PowerShell or Command Prompt opened as Administrator**.

### One‑Command Installation (Recommended)

Microsoft has simplified the installation to a single command:

1.  **Open PowerShell as Administrator** (right‑click and select *Run as Administrator*).

2.  **Run the following command**:
    ```powershell
    wsl --install
    ```

    This command will:
    -   Automatically enable the required Windows features (Virtual Machine Platform and Windows Subsystem for Linux).
    -   Download and install the **Ubuntu** distribution of Linux (the default).

3.  **Restart your machine** when prompted. After the restart, the installation will complete automatically.

> **Note:** If you see the WSL help text instead of an installation, it means WSL is already installed. You can list available distributions by running `wsl --list --online` and install a specific one with `wsl --install -d <DistroName>`.

### Changing the Default Linux Distribution

By default, Ubuntu is installed. To install a different distribution (e.g., Debian, Kali, or OpenSUSE), use the `-d` flag:

```powershell
wsl --install -d Debian
```

To see all available distributions:
```powershell
wsl --list --online
```

### First Launch

The first time you launch a newly installed Linux distribution (by typing `wsl` in PowerShell or clicking its Start menu icon), a console window will open, and you’ll be asked to wait for files to decompress. You will then be prompted to create a user account and password for your Linux environment.

### Verifying WSL Version

To check whether your distribution is running WSL 1 or WSL 2 (the latest version), run:
```powershell
wsl -l -v
```

If you need to upgrade a distribution from WSL 1 to WSL 2:
```powershell
wsl.exe --set-version <DistroName> 2
```

### Troubleshooting

-   **Installation hangs at 0%**:  
    Run the command with the `--web-download` flag to force a direct web download:
    ```powershell
    wsl --install --web-download -d <DistroName>
    ```
    

-   **Older versions of Windows**:  
    Follow the [manual installation steps](https://learn.microsoft.com/install-manual).

[Debian on WSL – Complete Development Setup](debian.md)
For complete documentation, visit the [official WSL documentation](https://learn.microsoft.com/en-us/windows/wsl/).


## ⚙️ What the Script Does

- Installs **PowerShell 7** if not already present.
- Installs **Oh My Posh** via `winget`.
- Sets the `POSH_THEMES_PATH` environment variable permanently (if missing) pointing to `$HOME\.posh-themes`.
- Copies your custom Oh My Posh theme (`hunta.omp.json`) into that path.
- Copies your **PowerShell profile** (with PSReadLine config, aliases, and Oh My Posh init) to its correct location.
- Copies all **VS Code profiles** (`.code-profile` files) into the VS Code user profiles directory.  
  ⚠️ You still need to **import each profile manually** in VS Code (`Profiles > Import Profile`).
- Installs every **VS Code extension** for each language profile by reading the `*.txt` files.
- Copies the global `settings.json` (and optionally `keybindings.json`) to the VS Code `User` folder.
-   Installs **Chocolatey** (if not already installed) and then uses it to install **Windows Terminal** and **WSL** (if desired).
-   Alternatively, provides instructions to manually install **WSL** with the single‑command `wsl --install`.

## 🔄 Keeping It Up‑to‑Date

- After making any changes to your setup (new extension, theme tweak, alias):
  1. Export the relevant file (e.g., VS Code profile or extension list).
  2. Overwrite the corresponding file in this repo.
  3. Commit and push:
     ```powershell
     git add .
     git commit -m "Update PHP extensions"
     git push
     ```

- On another machine, just pull the latest changes and run `./setup.ps1` again.  
  The script is idempotent – it will safely overwrite existing files.

## 🎨 Customisation Notes

- **Oh My Posh theme** – If you modify `hunta.omp.json`, place the updated file inside `.posh-themes/` and run the script again.
- **VS Code global settings** – Edit `vscode/settings.json` directly; it’s a partial file (not the full `settings.json`). It will be merged automatically when copied because VS Code reads it as JSON – but be careful not to lose any manual changes you may have made outside this repo.
- **PowerShell profile** – Any new aliases, functions, or PSReadLine options should be added to `powershell/Microsoft.PowerShell_profile.ps1`.

## 🚫 Troubleshooting

- **VS Code profiles not showing up after copy**  
  Copying the `.code-profile` file into the folder is not enough. You must manually import it: `Ctrl+Shift+P` → `Profiles: Import Profile` → select the file from `%APPDATA%\Code\User\profiles`.
- **`winget` not recognized**  
  Install the [App Installer](https://aka.ms/getwinget) from the Microsoft Store, or update your system.
- **Font glyphs (icons) look broken**  
  Make sure you installed the **Nerd Font** version of the font and set `"terminal.integrated.fontFamily"` in VS Code settings to exactly that font’s name.
- **Script fails with execution policy error**  
  Run `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass` before executing the script.
-   **Chocolatey installation fails with execution policy error**  
    Make sure you are running PowerShell as Administrator and that you have included the `Set-ExecutionPolicy Bypass -Scope Process -Force` part of the command.

-   **Windows Terminal does not launch after Chocolatey install**  
    Try installing from the Microsoft Store instead, or download the `.msixbundle` from GitHub and install it manually.

-   **WSL installation hangs at 0%**  
    Run `wsl --install --web-download -d Ubuntu` to force a direct web download. Also, ensure that virtualization is enabled in your BIOS/UEFI settings.

---

## 📦 Credits & Inspiration

- [Oh My Posh](https://ohmyposh.dev) – prompt theme engine.
- [VS Code Profiles](https://code.visualstudio.com/docs/editor/profiles) – official documentation.
- [Nerd Fonts](https://www.nerdfonts.com) – patched fonts with extra icons.
- The PowerShell community for countless dotfiles ideas.

---

**Happy coding!** ✌️