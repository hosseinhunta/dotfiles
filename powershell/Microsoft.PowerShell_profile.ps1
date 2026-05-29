# ==================== Oh My Posh ====================
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\hunta.omp.json" | Invoke-Expression

# ==================== PSReadLine ====================
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# ==================== Functions & Aliases ====================
function dev { Set-Location "D:\Projects" }
Set-Alias -Name g -Value git
function Edit-Profile { code $PROFILE }

# ---------- Linux/macOS style aliases ----------
# Navigation
function .. { Set-Location .. }
function ... { Set-Location ..\.. }
function - { Set-Location - }
function desktop { Set-Location ~\Desktop }

# ls with colors (using eza if available, fallback to built-in)
if (Get-Command eza -ErrorAction SilentlyContinue) {
    $colorflag = "--color=always --group-directories-first --icons"
    Set-Alias ls eza
    function l { eza -lF $colorflag }
    function la { eza -laF $colorflag }
    function lsd { eza -lF $colorflag --only-dirs }
} else {
    # Fallback: standard PowerShell Get-ChildItem
    Set-Alias ls Get-ChildItem
    function l { Get-ChildItem | Format-Table -AutoSize }
    function la { Get-ChildItem -Force | Format-Table -AutoSize }
    function lsd { Get-ChildItem -Directory | Format-Table -AutoSize }
}

# Other utilities
function web { start msedge }
function path { $env:PATH -split ';' }
function week { (Get-Date -UFormat %V) }