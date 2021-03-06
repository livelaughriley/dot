#requires -Version 2 -Modules posh-git

function Write-Theme {
    param(
        [bool]$lastCommandFailed,
        [string]$with
    )

    # Writes the drive portion
    $dir = "$(Get-FullPath -dir $PWD)".Replace("\", "/")

    $prompt += Write-Prompt -Object $dir -ForegroundColor $sl.Colors.DriveForegroundColor

    $status = Get-VCSStatus
    if ($status) {
        $prompt += Write-Prompt -Object " git:(" -ForegroundColor $sl.Colors.PromptHighlightColor
        $prompt += Write-Prompt -Object "$($status.Branch)" -ForegroundColor $sl.Colors.WithForegroundColor
        $prompt += Write-Prompt -Object ")" -ForegroundColor $sl.Colors.PromptHighlightColor
        if ($status.Working.Length -gt 0) {
            $prompt += Write-Prompt -Object (" " + $sl.PromptSymbols.GitDirtyIndicator) -ForegroundColor $sl.Colors.GitDirtyColor
        }
        else {
            $prompt += Write-Prompt -Object (" " + $sl.PromptSymbols.GitDefaultIndicator) -ForegroundColor $sl.Colors.GitDefaultColor
        }
    }

    $prompt += "`r`n"
    $prompt += "-> "
    $prompt
}

$sl = $global:ThemeSettings #local settings
$sl.Colors.PromptSymbolColor = [ConsoleColor]::Magenta
$sl.Colors.PromptHighlightColor = [ConsoleColor]::Blue
$sl.Colors.PromptAtColor = [ConsoleColor]::DarkBlue
$sl.Colors.DriveForegroundColor = [ConsoleColor]::DarkMagenta
$sl.Colors.WithForegroundColor = [ConsoleColor]::Red
$sl.PromptSymbols.GitDefaultIndicator = ""
$sl.PromptSymbols.GitDirtyIndicator = '署'
$sl.Colors.GitDefaultColor = [ConsoleColor]::DarkGreen
$sl.Colors.GitDirtyColor = [ConsoleColor]::DarkRed