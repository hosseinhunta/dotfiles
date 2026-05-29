# setup.ps1
# Run with PowerShell 7 as Administrator
$ErrorActionPreference = "Stop"

Write-Host "🚀 Starting development environment restoration..." -ForegroundColor Cyan

if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host "📥 Installing PowerShell 7..."
    winget install Microsoft.PowerShell --accept-source-agreements
}

Write-Host "📥 Installing Oh My Posh..."
winget install JanDeDobbeleer.OhMyPosh --accept-source-agreements

Write-Host "❗ Please install the required Nerd Fonts manually. See the fonts folder for links." -ForegroundColor Yellow

$psProfileDir = Split-Path -Path $PROFILE -Parent
if (!(Test-Path $psProfileDir)) {
    New-Item -ItemType Directory -Path $psProfileDir -Force
}
Copy-Item -Path ".\powershell\Microsoft.PowerShell_profile.ps1" -Destination $PROFILE -Force
Write-Host "✅ PowerShell profile installed."

Write-Host "🎨 Setting up Oh My Posh custom theme..."

$defaultPoshThemesPath = Join-Path $HOME ".posh-themes"

$currentPoshPath = [Environment]::GetEnvironmentVariable("POSH_THEMES_PATH", "User")

if (-not $currentPoshPath) {
    Write-Host "🔧 Setting POSH_THEMES_PATH environment variable to $defaultPoshThemesPath"
    [Environment]::SetEnvironmentVariable("POSH_THEMES_PATH", $defaultPoshThemesPath, "User")
    $env:POSH_THEMES_PATH = $defaultPoshThemesPath
    $poshThemesPath = $defaultPoshThemesPath
} else {
    $poshThemesPath = $currentPoshPath
    Write-Host "ℹ️ POSH_THEMES_PATH already set to $poshThemesPath"
}

if (-not (Test-Path $poshThemesPath)) {
    New-Item -ItemType Directory -Path $poshThemesPath -Force | Out-Null
}

$localThemeSource = ".\posh-themes\hunta.omp.json"   # Adjust folder name as per your repo
if (Test-Path $localThemeSource) {
    Copy-Item -Path $localThemeSource -Destination $poshThemesPath -Force
    Write-Host "✅ Custom theme 'hunta.omp.json' copied to $poshThemesPath"
} else {
    Write-Host "⚠️ Theme file not found at $localThemeSource. Skipping theme copy." -ForegroundColor Yellow
}

Write-Host "Installing eza (modern ls replacement)..." -ForegroundColor Cyan
winget install eza-community.eza --accept-package-agreements

Write-Host "🔄 Restoring VS Code profiles..."
if (!(Get-Command code -ErrorAction SilentlyContinue)) {
    Write-Host "❌ VS Code not found. Please install Visual Studio Code first." -ForegroundColor Red
    exit 1
}
$vscodeProfilesDir = "$env:APPDATA\Code\User\profiles"
if (!(Test-Path $vscodeProfilesDir)) {
    New-Item -ItemType Directory -Path $vscodeProfilesDir -Force
}

if (Test-Path ".\vscode-profiles") {
    Get-ChildItem ".\vscode-profiles\*.code-profile" | ForEach-Object {
        Copy-Item $_.FullName -Destination $vscodeProfilesDir -Force
    }
    Write-Host "✅ VS Code profiles copied."
    
    Get-ChildItem ".\vscode-profiles\*.code-profile" | ForEach-Object {
        Write-Host "Importing profile $($_.BaseName)..."
        code --import-profile $_.FullName --wait
    }
} else {
    Write-Host "⚠️ No vscode-profiles folder found. Skipping." -ForegroundColor Yellow
}
Write-Host "✅ VS Code profiles copied. Open VS Code and import each profile manually via Profiles > Import Profile."

Write-Host "📥 Installing VS Code extensions..."
$extensionsDir = ".\vscode-extensions"
if (Test-Path $extensionsDir) {
    Get-ChildItem $extensionsDir -Filter "*.txt" | ForEach-Object {
    $profileName = $_.BaseName -replace "-extensions",""
    Write-Host "🔹 Installing extensions for profile: $profileName"
    Get-Content $_.FullName | ForEach-Object {
        code --install-extension $_ --profile $profileName --force
    }
}
} else {
    Write-Host "⚠️ No extensions folder found. Skipping." -ForegroundColor Yellow
}

Write-Host "✅ Extensions installed."
Copy-Item -Path ".\vscode\settings.json" -Destination "$env:APPDATA\Code\User\settings.json" -Force
# Copy-Item -Path ".\vscode\keybindings.json" -Destination "$env:APPDATA\Code\User\keybindings.json" -Force
Write-Host "✅ VS Code global settings installed."

Write-Host "🎉 All done! Please restart PowerShell and VS Code." -ForegroundColor Green