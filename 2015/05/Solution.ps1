# https://adventofcode.com/2015/day/5

#region Part 1

$puzzleInput = Get-Content -Path '.\input.txt'

$vowelRegex = '[aeiou]'
$repeatRegex = '(.)\1'
$badRegex = 'ab|cd|pq|xy'
$result = 0

foreach ($string in $puzzleInput) {
    if ([regex]::Matches($string,$vowelRegex).Count -lt 3) {
        continue
    }
    if ($string -notmatch $repeatRegex) {
        continue
    }
    if ($string -match $badRegex) {
        continue
    }
    $result++
}

Write-Host ('Number of Nice Strings: {0}' -f $result) -ForegroundColor Green

#endregion

#region Part 2
$niceRegex1 = '(?=(..).*?\1)'
$niceRegex2 = '(.).\1'
$result = 0

foreach ($string in $puzzleInput) {
    if ($string -notmatch $niceRegex1 -or $string -notmatch $niceRegex2) {
        continue
    }
    $result++
}

Write-Host ('Number of Nice Strings: {0}' -f $result) -ForegroundColor Green
#endregion