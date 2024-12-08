# https://adventofcode.com/2024/day/2

#region Part 1

$puzzleInput = Get-Content -Path '.\Input.txt'

$safeReports = [System.Collections.Generic.List[string]]::new()
foreach ($report in $puzzleInput) {
    [int[]]$levels = $report -split ' '

    # Guard when neither increasing nor decreasing
    if ($levels[0] -eq $levels[-1]) {
        continue
    }

    $isIncreasing = $levels[0] -lt $levels[-1]

    $isSafe = $true
    for ($i = 1; $i -lt $levels.Count; $i++) {
        # Guard clause for increase/decrease
        if (($levels[$i-1] -lt $levels[$i]) -ne $isIncreasing) {
            $isSafe = $false
            break
        }

        # Guard clause for difference
        $diff = $levels[$i-1] - $levels[$i]
        if ([math]::Abs($diff) -lt 1 -or [math]::Abs($diff) -gt 3) {
            $isSafe = $false
            break
        }
    }

    if ($isSafe) {
        $safeReports.Add($report)
    }
}

# Return result
Write-Host ('Total safe reports: {0}' -f $safeReports.Count) -ForegroundColor Green

#endregion

#region Part 2

function Test-ReportLevel {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [System.Int32[]]
        $Levels
    )

    # Guard when neither increasing nor decreasing
    if ($Levels[0] -eq $Levels[-1]) {
        return $false
    }

    $isIncreasing = $Levels[0] -lt $Levels[-1]
    for ($i = 1; $i -lt $Levels.Count; $i++) {
        # Guard clause for increase/decrease
        if (($Levels[$i-1] -lt $Levels[$i]) -ne $isIncreasing) {
            return $false
        }

        # Guard clause for difference
        $diff = $Levels[$i-1] - $Levels[$i]
        if ([math]::Abs($diff) -lt 1 -or [math]::Abs($diff) -gt 3) {
            return $false
        }
    }

    return $true
}

$safeReportsWithDampener = [System.Collections.Generic.List[string]]::new()
foreach ($report in $puzzleInput) {
    [System.Collections.Generic.List[int]] $levels = $report -split ' '
    $isSafe = Test-ReportLevel -Levels $levels

    if (-not $isSafe) {
        $i = 0
        do {
            $dampenedLevel = [System.Collections.Generic.List[int]]::new($levels)
            $dampenedLevel.RemoveAt($i)
            $isSafe = Test-ReportLevel -Levels $dampenedLevel
            $i++
        } while ($i -lt $levels.Count -and -not $isSafe)
    }

    if ($isSafe) {
        $safeReportsWithDampener.Add($report)
    }
}

Write-Host ('Total safe reports with dampener: {0}' -f $safeReportsWithDampener.Count) -ForegroundColor Green

#endregion