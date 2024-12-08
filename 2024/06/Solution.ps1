# https://adventofcode.com/2024/day/6

#region Part 1

$puzzleInput = Get-Content -Path '.\input.txt'

function Move-Guard {
    [CmdletBinding()]
    param (

    )
    # Set the current location to visited
    $map["$($Guard.Row),$($Guard.Col)"] = 'X'

    # Get the next coordinate
    $nextCoords = switch ($Guard.Direction) {
        '^' {
            @(
                $Guard.Row-1
                $Guard.Col
            )
        }
        '>' {
            @(
                $Guard.Row
                $Guard.Col+1
            )
        }
        'V' {
            @(
                $Guard.Row+1
                $Guard.Col
            )
        }
        '<' {
            @(
                $Guard.Row
                $Guard.Col-1
            )
        }
    }

    $nextValue = $Map["$($nextCoords[0]),$($nextCoords[1])"]
    if ($nextValue -eq '#') {
        $Guard.Direction = $script:changeDirection[$Guard.Direction]
        Write-Verbose -Message ('Guard has changed directions to {0}!' -f $Guard.Direction)
    }
    elseif ($null -ne $nextValue) {
        $Guard.Row = $nextCoords[0]
        $Guard.Col = $nextCoords[1]
        Write-Verbose -Message ('Guard has moved to {0},{1}!' -f $Guard.Row,$Guard.Col)
    }
    else {
        Write-Verbose -Message 'Guard has left the area!'
        return $false
    }

    return $true
}

function Show-Map {
    $colorMap = @{
        '.' = 'White'
        'X' = 'Green'
        '#' = 'Cyan'
    }

    for ($row = 0; $row -lt $puzzleInput.Count; $row++) {
        for ($col = 0; $col -lt $puzzleInput[$row].Length; $col++) {
            $value = $script:map["$row,$col"]
            Write-Host $value -NoNewline -ForegroundColor $colorMap["$value"]
        }
        Write-Host ''
    }
}

function New-Map {
    param (
        $PuzzleInput
    )
    # Create the map as a hashtable
    $script:map = @{}
    for ($row = 0; $row -lt $PuzzleInput.Count; $row++) {
        for ($col = 0; $col -lt $PuzzleInput[$row].Length; $col++) {
            $map["$row,$col"] = $PuzzleInput[$row][$col]
            if ($PuzzleInput[$row][$col] -eq '^') {
                $script:startingCoords = @($row,$col)
            }
        }
    }
}

# Create the hash map of coordinates
New-Map -PuzzleInput $puzzleInput

# Create the guard
$guard = [pscustomobject]@{
    Direction = '^'
    Row = $startingCoords[0]
    Col = $startingCoords[1]
}

# Changing directions
$script:changeDirection = @{
    '^' = '>'
    '>' = 'V'
    'V' = '<'
    '<' = '^'
}

try {
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    $actions = 0
    do {
        $moved = Move-Guard
        $actions++
    } while ($moved)

    $result = 0
    $map.GetEnumerator() | ForEach-Object {
        if ($_.Value -eq 'X') {
            $result++
        }
    }
}
finally {
    $stopwatch.Stop()
    Write-Host ('Distinct Guard Positions: {0}' -f $result) -ForegroundColor Green
    Write-Host "Elapsed Time: $($stopwatch.ElapsedMilliseconds) ms"
    Write-Host "Actions Performed: $actions"
}

#endregion
