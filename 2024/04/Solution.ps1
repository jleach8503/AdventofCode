# https://adventofcode.com/2024/day/4

#region Part 1

$puzzleInput = Get-Content -Path '.\input.txt'

# Initialize values
$maxRow = $puzzleInput.Count
$maxCol = $puzzleInput.Length
$result = 0

for ($i = 0; $i -lt $maxRow; $i++) {
    # Are there enough rows remaining for matches
    $hasRows = $i -le $maxRow-4

    for ($j = 0; $j -lt $maxCol; $j++) {
        # Are there enough columns remaining for matches
        $hasCols = $j -le $maxCol-4

        # No possible matches due to remaining rows/cols or first character isnt X or S
        if ((-not $hasRows -and -not $hasCols) -or $puzzleInput[$i][$j] -notin @('X','S')) {
            continue
        }

        # Test for vertical match
        if ($hasRows) {
            $slice = $puzzleInput[$i][$j],$puzzleInput[$i+1][$j],$puzzleInput[$i+2][$j],$puzzleInput[$i+3][$j] -join ''
            if ($slice -in @('XMAS','SAMX')) {
                $result++
            }
        }

        # Not enough columns for any more matches
        if (-not $hasCols) {
            continue
        }

        # Test for horizontal matches
        $slice = $puzzleInput[$i][$j],$puzzleInput[$i][$j+1],$puzzleInput[$i][$j+2],$puzzleInput[$i][$j+3] -join ''
        if ($slice -in @('XMAS','SAMX')) {
            $result++
        }

        # Look for down diagonal matches
        if ($hasRows) {
            $slice = $puzzleInput[$i][$j],$puzzleInput[$i+1][$j+1],$puzzleInput[$i+2][$j+2],$puzzleInput[$i+3][$j+3] -join ''
            if ($slice -in @('XMAS','SAMX')) {
                $result++
            }
        }

        # Look for up diagonal matches
        if ($i -ge 3) {
            $slice = $puzzleInput[$i][$j],$puzzleInput[$i-1][$j+1],$puzzleInput[$i-2][$j+2],$puzzleInput[$i-3][$j+3] -join ''
            if ($slice -in @('XMAS','SAMX')) {
                $result++
            }
        }
    }
}

Write-Host ('XMAS Word Search Result: {0}' -f $result) -ForegroundColor Green

#endregion

#region Part 2

# Initialize values
$maxRow = $puzzleInput.Count
$maxCol = $puzzleInput.Length
$indexes = [System.Collections.Generic.List[string]]::new()

for ($i = 1; $i -lt $maxRow-1; $i++) {
    for ($j = 1; $j -lt $maxCol-1; $j++) {
        # The indexed character must be 'A'
        if ($puzzleInput[$i][$j] -ne 'A') {
            continue
        }

        $diag1 = ($puzzleInput[$i-1][$j-1],$puzzleInput[$i+1][$j+1] | Sort-Object) -join ''
        $diag2 = ($puzzleInput[$i-1][$j+1],$puzzleInput[$i+1][$j-1] | Sort-Object) -join ''
        if ($diag1 -eq 'MS' -and $diag2 -eq 'MS') {
            $indexes.Add("$i,$j")
        }
    }
}

Write-Host ('X-MAS Word Search Result: {0}' -f $indexes.Count) -ForegroundColor Green

#endregion
