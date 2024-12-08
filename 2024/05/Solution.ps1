# https://adventofcode.com/2024/day/5

#region Part 1

$puzzleInput = Get-Content -Path '.\input.txt'

# Save the rules as a list where index 0 should come before index 1
$allRules = [System.Collections.Generic.List[int[]]]::new()
($puzzleInput[0..($puzzleInput.IndexOf('')-1)]) | ForEach-Object { $allRules.Add([int[]]($_ -split '\|')) }

# Save the updates as a list where index 0 should come before index 1
$allUpdates = [System.Collections.Generic.List[int[]]]::new()
$puzzleInput[($puzzleInput.IndexOf('')+1)..($puzzleInput.Count-1)] | ForEach-Object { $allUpdates.Add([int[]]($_ -split ','))}

function Test-UpdateRules {
    param (
        $UpdateRules,
        $Update
    )

    $applicableRules = $UpdateRules | Where-Object { $_[0] -in $Update -and $_[1] -in $Update }
    foreach ($page in $Update) {
        $pageRules = $applicableRules | Where-Object { $_ -contains $page }
        foreach ($rule in $pageRules) {
            if ($Update.IndexOf($rule[0]) -gt $Update.IndexOf($rule[1])) {
                return $false
            }
        }
    }

    return $true
}

$result = 0
foreach ($update in $allUpdates) {
    $passedTest = Test-UpdateRules -UpdateRules $allRules -Update $update
    if ($passedTest) {
        $result += $update[[math]::Floor($update.count/2)]
    }
}

Write-Host ('Correctly Ordered Middle Page Sum: {0}' -f $result) -ForegroundColor Green

#endregion

#region Part 2

function Repair-Update {
    param (
        $UpdateRules,
        $Update
    )

    $repairedUpdate = [System.Collections.Generic.List[int]]::new($Update)
    $applicableRules = $UpdateRules | Where-Object { $_[0] -in $Update -and $_[1] -in $Update }
    foreach ($page in $Update) {
        $pageRules = $applicableRules | Where-Object { $_ -contains $page }
        foreach ($rule in $pageRules) {
            if ($repairedUpdate.IndexOf($rule[0]) -gt $repairedUpdate.IndexOf($rule[1])) {
                $repairedUpdate.RemoveAt($repairedUpdate.IndexOf($rule[0]))
                $repairedUpdate.Insert($repairedUpdate.IndexOf($rule[1]),$rule[0])
            }
        }
    }

    return $repairedUpdate
}

$result = 0
foreach ($update in $allUpdates) {
    $passedTest = Test-UpdateRules -UpdateRules $allRules -Update $update
    if (-not $passedTest) {
        $fixedUpdate = Repair-Update -UpdateRules $allRules -Update $update
        $result += $fixedUpdate[[math]::Floor($fixedUpdate.count/2)]
    }
}

Write-Host ('Incorrectly Ordered Middle Page Sum: {0}' -f $result) -ForegroundColor Green

#endregion
