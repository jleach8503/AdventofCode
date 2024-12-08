# https://adventofcode.com/2015/day/2

#region Part 1

$puzzleInput = Get-Content -Path '.\input.txt'

$result = 0
foreach ($dimension in $puzzleInput) {
    [int]$l,[int]$w,[int]$h = $dimension -split 'x'
    [System.Collections.Generic.List[int]]$area = @(
        $l*$w
        $w*$h
        $h*$l
    )
    $area.Sort()
    $result += $area[0] * 3 + $area[1] * 2 + $area[2] * 2
}


Write-Host ('Total Paper Required: {0}' -f $result) -ForegroundColor Green

#endregion

#region Part 2

$result = 0
foreach ($dimension in $puzzleInput) {
    [System.Collections.Generic.List[int]]$area = $dimension -split 'x'
    $area.Sort()
    $result += $area[0] * 2 + $area[1] * 2 + ($area[0] * $area[1] * $area[2])
}

Write-Host ('Total Ribbon Required: {0}' -f $result) -ForegroundColor Green
#endregion