<#
--- Day 4: Ceres Search ---
"Looks like the Chief's not here. Next!" One of The Historians pulls out a device and pushes the only button on it. After a brief flash, you recognize the interior of the Ceres monitoring station!

As the search for the Chief continues, a small Elf who lives on the station tugs on your shirt; she'd like to know if you could help her with her word search (your puzzle input). She only has to find one word: XMAS.

This word search allows words to be horizontal, vertical, diagonal, written backwards, or even overlapping other words. It's a little unusual, though, as you don't merely need to find one instance of XMAS - you need to find all of them. Here are a few ways XMAS might appear, where irrelevant characters have been replaced with .:


..X...
.SAMX.
.A..A.
XMAS.S
.X....
The actual word search will be full of letters instead. For example:

MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
In this word search, XMAS occurs a total of 18 times; here's the same word search again, but where letters not involved in any XMAS have been replaced with .:

....XXMAS.
.SAMXMS...
...S..A...
..A.A.MS.X
XMASAMX.MM
X.....XA.A
S.S.S.S.SS
.A.A.A.A.A
..M.M.M.MM
.X.X.XMASX
Take a look at the little Elf's word search. How many times does XMAS appear?
#>

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

<#
--- Part Two ---
The Elf looks quizzically at you. Did you misunderstand the assignment?

Looking for the instructions, you flip over the word search to find that this isn't actually an XMAS puzzle; it's an X-MAS puzzle in which you're supposed to find two MAS in the shape of an X. One way to achieve that is like this:

M.S
.A.
M.S
Irrelevant characters have again been replaced with . in the above diagram. Within the X, each MAS can be written forwards or backwards.

Here's the same example from before, but this time all of the X-MASes have been kept instead:

.M.S......
..A..MSMS.
.M.S.MAA..
..A.ASMSM.
.M.S.M....
..........
S.S.S.S.S.
.A.A.A.A..
M.M.M.M.M.
..........
In this example, an X-MAS appears 9 times.

Flip the word search from the instructions back over to the word search side and try again. How many times does an X-MAS appear?
#>

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