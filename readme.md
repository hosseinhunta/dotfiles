# 🚀 My Developer Dotfiles

A fully automated development environment setup for Windows.  
This repository contains all my configurations for **PowerShell**, **Oh My Posh**, **VS Code profiles**, **extensions**, and **fonts** – ready to be deployed on any fresh Windows machine with a single script.

## 📂 Repository Structure

```
dotfiles/
├── setup.ps1                          # Main installation script
├── powershell/
│   └── Microsoft.PowerShell_profile.ps1
├── .posh-themes/
│   └── hunta.omp.json                 # Custom Oh My Posh theme
├── vscode/
│   ├── settings.json                  # Global VS Code settings (font, cursor, etc.)
│   └── (keybindings.json)             # Optional – uncomment in script if needed
├── vscode-profiles/
│   ├── php.code-profile
│   ├── python.code-profile
│   └── typescript.code-profile
├── vscode-extensions/
│   ├── php-extensions.txt
│   ├── python-extensions.txt
│   └── typescript-extensions.txt
└── fonts/
    └── README.md                      # Links to required Nerd Fonts
```

## ✨ What’s Inside?

- **PowerShell 7** – modern, cross‑platform shell.
- **Oh My Posh** – beautiful, customisable prompt with a custom theme.
- **PSReadLine** – intelligent auto‑suggestions and history search (configured inside the PowerShell profile).
- **VS Code** – fully isolated language profiles for PHP, Python, and TypeScript/JavaScript, each with its own extensions and settings.
- **Nerd Fonts** – ligature‑rich coding fonts (manual installation required).
- **Terminal look & feel** – smooth scrolling, cursor animations, minimal UI.

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

## 📦 Credits & Inspiration

- [Oh My Posh](https://ohmyposh.dev) – prompt theme engine.
- [VS Code Profiles](https://code.visualstudio.com/docs/editor/profiles) – official documentation.
- [Nerd Fonts](https://www.nerdfonts.com) – patched fonts with extra icons.
- The PowerShell community for countless dotfiles ideas.

---

**Happy coding!** ✌️