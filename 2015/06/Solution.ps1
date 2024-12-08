# https://adventofcode.com/2015/day/6

#region Part 1

$puzzleInput = Get-Content -Path '.\input.txt'

$lightGrid = New-Object 'bool[,]' 1000,1000
foreach ($instruction in $puzzleInput) {
    Write-Host ("Processing instruction {0} of {1}`r" -f $puzzleInput.IndexOf($instruction),$puzzleInput.Count) -NoNewline -ForegroundColor Cyan
    $start,$end = $instruction -split ' through '
    $action = $start.Substring(0,$start.LastIndexOf(' ')).Trim()
    $startCoord = $start.Substring($start.LastIndexOf(' ')+1) -split ','
    $endCoord = $end -split ','

    for ([int]$x = $startCoord[0]; $x -le $endCoord[0]; $x++) {
        for ([int]$y = $startCoord[1]; $y -le $endCoord[1]; $y++) {
            if ($action -eq 'turn on') {
                $lightGrid[$x,$y] = $true
            }
            elseif ($action -eq 'turn off') {
                $lightGrid[$x,$y] = $false
            }
            else {
                $lightGrid[$x,$y] = -not $lightGrid[$x,$y]
            }
        }
    }

    Remove-Variable start,end
}

$result = $lightGrid.Where{$_}.Count

Write-Host ('Number of Lights Turned On: {0}' -f $result) -ForegroundColor Green

#endregion

#region Part 2

$lightGrid = New-Object 'int[,]' 1000,1000
foreach ($instruction in $puzzleInput) {
    Write-Host ("Processing instruction {0} of {1}`r" -f $puzzleInput.IndexOf($instruction),$puzzleInput.Count) -NoNewline -ForegroundColor Cyan
    $start,$end = $instruction -split ' through '
    $action = $start.Substring(0,$start.LastIndexOf(' ')).Trim()
    $startCoord = $start.Substring($start.LastIndexOf(' ')+1) -split ','
    $endCoord = $end -split ','

    for ([int]$x = $startCoord[0]; $x -le $endCoord[0]; $x++) {
        for ([int]$y = $startCoord[1]; $y -le $endCoord[1]; $y++) {
            if ($action -eq 'turn on') {
                $lightGrid[$x,$y]++
            }
            elseif ($action -eq 'turn off') {
                if ($lightGrid[$x,$y] -gt 0) {
                    $lightGrid[$x,$y]--
                }
            }
            else {
                $lightGrid[$x,$y] += 2
            }
        }
    }

    Remove-Variable start,end
}

$result = ($lightGrid | Measure-Object -Sum).Sum

Write-Host ('Total Brightness: {0}' -f $result) -ForegroundColor Green

#endregion