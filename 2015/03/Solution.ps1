# https://adventofcode.com/2015/day/3

#region Part 1

$puzzleInput = Get-Content -Path '.\input.txt'

$currentCoords = @(0,0)
$houses = @{
    "$($currentCoords -join ',')" = 1
}

for ($i = 0; $i -lt $puzzleInput.Length; $i++) {
    switch ($puzzleInput[$i]) {
        '>' {
            $currentCoords[0]++
        }
        'V' {
            $currentCoords[1]++
        }
        '<' {
            $currentCoords[0]--
        }
        '^' {
            $currentCoords[1]--
        }
    }
    if (-not $houses.ContainsKey("$($currentCoords -join ',')")) {
        $houses[$currentCoords -join ','] = 0
    }
    $houses[$currentCoords -join ',']++
}

$result = $houses.Keys.Count

Write-Host ('Houses Receiving Presents: {0}' -f $result) -ForegroundColor Green

#endregion

#region Part 2

$currentCoords = @(
    ,@(0,0) # Santa
    ,@(0,0) # Robo-Santa
)
$houses = @{
    "0,0" = 2
}

for ($i = 0; $i -lt $puzzleInput.Length; $i++) {
    $switcher = $i % 2
    switch ($puzzleInput[$i]) {
        '>' {
            $currentCoords[$switcher][0]++
        }
        'V' {
            $currentCoords[$switcher][1]++
        }
        '<' {
            $currentCoords[$switcher][0]--
        }
        '^' {
            $currentCoords[$switcher][1]--
        }
    }
    $houseKey = $currentCoords[$switcher] -join ','
    if (-not $houses.ContainsKey("$houseKey")) {
        $houses["$houseKey"] = 0
    }
    $houses["$houseKey"]++
}

$result = $houses.Keys.Count

Write-Host ('Total Ribbon Required: {0}' -f $result) -ForegroundColor Green
#endregion