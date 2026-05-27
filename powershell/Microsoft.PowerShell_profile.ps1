oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\hunta.omp.json" | Invoke-Expression

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

function dev { Set-Location "D:\Projects" }
Set-Alias -Name g -Value git
function Edit-Profile { code $PROFILE }
