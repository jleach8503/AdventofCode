# https://adventofcode.com/2024/day/1

#region Part 1

$puzzleInput = Get-Content -Path '.\Input.txt'

# Clean up the input into left and right lists
$puzzleInput = $puzzleInput -split "`n"
$leftList = [System.Collections.Generic.List[int]]::new($puzzleInput.Count)
$rightList = [System.Collections.Generic.List[int]]::new($puzzleInput.Count)
$puzzleInput | ForEach-Object {
    $splitValues = $_ -split '   '
    $leftList.Add($splitValues[0])
    $rightList.Add($splitValues[1])
}

# Sort the lists and add the distance for each index
$leftList.Sort()
$rightList.Sort()
$totalDistance = 0
for ($i = 0; $i -lt $leftList.Count; $i++) {
    $totalDistance += [math]::Abs($leftList[$i] - $rightList[$i])
}

# Return result
Write-Host ('Total distance between lists: {0}' -f $totalDistance)

#endregion

#region Part 2

$similarity = 0
foreach ($leftValue in $leftList) {
    $similarity += $leftValue * $rightList.Where{$_ -eq $leftValue}.Count
}

# Return result
Write-Host ('Similarity score of lists: {0}' -f $similarity)

#endregion