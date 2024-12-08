# https://adventofcode.com/2015/day/1

#region Part 1

$puzzleInput = Get-Content -Path '.\input.txt'

$currentFloor = 0
for ($i = 0; $i -lt $puzzleInput.Length; $i++) {
    if ($puzzleInput[$i] -eq '(') {
        $currentFloor++
    }
    elseif ($puzzleInput[$i] -eq ')') {
        $currentFloor--
    }
}

Write-Host ('Current Floor: {0}' -f $currentFloor) -ForegroundColor Green

#endregion

#region Part 2

$currentFloor = 0
for ($i = 0; $i -lt $puzzleInput.Length; $i++) {
    if ($puzzleInput[$i] -eq '(') {
        $currentFloor++
    }
    elseif ($puzzleInput[$i] -eq ')') {
        $currentFloor--
    }

    if ($currentFloor -lt 0) {
        break
    }
}

Write-Host ('Position When Basement: {0}' -f ($i+1)) -ForegroundColor Green
#endregion