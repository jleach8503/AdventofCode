# https://adventofcode.com/2024/day/3

#region Part 1

$puzzleInput = Get-Content -Path '.\Input.txt' -Raw

$regex = '(?<operation>mul)\((?<xValue>\d{1,3}),(?<yValue>\d{1,3})\)'
foreach ($instruction in ([regex]::Matches($puzzleInput,$regex))) {
    $result += [int]$instruction.Groups['xValue'].Value * [int]$instruction.Groups['yValue'].Value
}

Write-Host ('Uncorrupted mul instructions result: {0}' -f $result) -ForegroundColor Green

#endregion

#region Part 2

$regex = "(?<enable>do\(\)|don't\(\))|(?<operation>mul)\((?<xValue>\d{1,3}),(?<yValue>\d{1,3})\)"
$enabled = $true
foreach ($instruction in ([regex]::Matches($puzzleInput,$regex))) {
    # Check for enablement
    if ($instruction.Value -in @("don't()",'do()')) {
        $enabled = $instruction.Value -eq 'do()'
        continue
    }
    # Skip instruction if disabled
    if (-not $enabled) {
        continue
    }
    $enabledResult += [int]$instruction.Groups['xValue'].Value * [int]$instruction.Groups['yValue'].Value
}

Write-Host ('Uncorrupted mul instructions with enablement result: {0}' -f $enabledResult) -ForegroundColor Green

#endregion
