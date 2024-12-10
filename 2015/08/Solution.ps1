# https://adventofcode.com/2015/day/8

#region Part 1

$puzzleInput = Get-Content -Path '.\input.txt'

$script:escapeSequences = @{
    '\\\\' = '\'
    '\\"' = '"'
    '\\x([0-9A-Fa-f]{2})' = {
        $hexValue = [regex]::Match($_,'\\x([0-9A-Fa-f]{2})').Groups[1].Value
        [char]([convert]::ToInt32($hexValue,16))
    }
}

function Get-EscapedString {
    param (
        [string] $String,
        [switch] $WriteHost,
        [switch] $Unescape
    )

    if ($Unescape) {
        $escapeResult = $String
        $sequenceHash = $script:unescapeSequences
    }
    else {
        $sequenceHash = $script:escapeSequences
        $escapeResult = $String.Substring(1,$String.Length-2)
    }

    foreach ($sequence in $sequenceHash.GetEnumerator()) {
        $escapeResult = $escapeResult -replace $sequence.Name,$sequence.Value
    }

    if ($Unescape) {
        $escapeResult = '"{0}"' -f $escapeResult
    }

    if ($WriteHost) {
        Write-Host ('Input  ({0}): {1}' -f $String,$String.Length) -ForegroundColor Cyan
        Write-Host ('Output ({0}): {1}' -f $escapeResult,$escapeResult.Length) -ForegroundColor Green
    }
    $escapeResult
}

$codeLength = 0
$memoryLength = 0

foreach ($line in $puzzleInput) {
    $codeLength += $line.Length

    # Process all escaped sequences
    $processedLine = Get-EscapedString -String $line

    $memoryLength += $processedLine.Length
}
$result = $codeLength - $memoryLength

Write-Host ('Code Length minus Memory Length: {0}' -f $result) -ForegroundColor Green

#endregion

#region Part 2

$script:unescapeSequences = [ordered]@{
    '\\' = '\\'
    '\"' = '\"'
}

$codeLength = 0
$memoryLength = 0

foreach ($line in $puzzleInput) {
    $codeLength += $line.Length

    # Process all escaped sequences
    $processedLine = Get-EscapedString -String $line -Unescape

    $memoryLength += $processedLine.Length
}
$result = $memoryLength - $codeLength

Write-Host ('Encoded Length minus Coded Length: {0}' -f $result) -ForegroundColor Green

#endregion