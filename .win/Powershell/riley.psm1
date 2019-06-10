#requires -Version 2 -Modules posh-git

function Write-Theme {
    param(
        [bool]
        $lastCommandFailed,
        [string]
        $with
    )

    #check the last command state and indicate if failed
    $promtSymbolColor = $sl.Colors.PromptSymbolColor
    If ($lastCommandFailed) {
        $promtSymbolColor = $sl.Colors.WithForegroundColor
    }

    # Writes the postfixes to the prompt
    #$prompt += Write-Prompt -Object ($sl.PromptSymbols.PromptIndicator + "  ") -ForegroundColor $promtSymbolColor

    # Writes the drive portion
    $drive = "~"
    if ($pwd.Path -ne $HOME) {
        $drive = "$(Split-Path -path $pwd -Leaf)"
    }
    $prompt += Write-Prompt -Object $drive -ForegroundColor $sl.Colors.DriveForegroundColor

    $status = Get-VCSStatus
    if ($status) {
        $prompt += Write-Prompt -Object " git:(" -ForegroundColor $sl.Colors.PromptHighlightColor
        $prompt += Write-Prompt -Object "$($status.Branch)" -ForegroundColor $sl.Colors.WithForegroundColor
        $prompt += Write-Prompt -Object ")" -ForegroundColor $sl.Colors.PromptHighlightColor
        if ($status.Working.Length -gt 0) {
            $prompt += Write-Prompt -Object (" " + $sl.PromptSymbols.GitDirtyIndicator) -ForegroundColor $sl.Colors.GitDirtyColor
        } else {
            $prompt += Write-Prompt -Object (" " + $sl.PromptSymbols.GitDefaultIndicator) -ForegroundColor $sl.Colors.GitDefaultColor
        }
    } 
    
    $prompt += "`r`n"
    $prompt += "> "
    $prompt
}

$sl = $global:ThemeSettings #local settings
$sl.PromptSymbols.PromptIndicator = [char]::ConvertFromUtf32(0x221a)
$sl.Colors.PromptSymbolColor = [ConsoleColor]::Magenta
$sl.Colors.PromptHighlightColor = [ConsoleColor]::Blue
$sl.Colors.DriveForegroundColor = [ConsoleColor]::DarkMagenta
$sl.Colors.WithForegroundColor = [ConsoleColor]::Red
$sl.PromptSymbols.GitDefaultIndicator = [char]::ConvertFromUtf32(0x221a)
$sl.PromptSymbols.GitDirtyIndicator = '×'
$sl.Colors.GitDefaultColor = [ConsoleColor]::DarkGreen
$sl.Colors.GitDirtyColor = [ConsoleColor]::DarkRed
