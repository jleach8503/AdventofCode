# https://adventofcode.com/2015/day/7

#region Part 1

$puzzleInput = Get-Content -Path '.\input.txt'

$operationMap = @{
    'OR' = { param([UInt16]$a,[UInt16]$b)
        $a -bor $b
    }
    'AND' = { param([UInt16]$a,[UInt16]$b)
        $a -band $b
    }
    'NOT' = { param([UInt16]$a)
        [UInt16]($a -bxor 0XFFFF)
    }
    'LSHIFT' = { param([UInt16]$a,[UInt16]$b)
        $a -shl $b
    }
    'RSHIFT' = { param([UInt16]$a,[UInt16]$b)
        $a -shr $b
    }
}

function Resolve-WireValue {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [System.String]
        $Instruction
    )

    $operation,$wire = $Instruction -split ' -> '
    $regexMatch = [regex]::Match($operation,($operationMap.Keys -join '|'))

    if ($regexMatch.Success) {
        $op = $regexMatch.Value
        if ($regexMatch.Value -eq 'NOT') {
            $parts = $operation -replace 'NOT\s+',''
        }
        else {
            $parts = $operation -split "\s+$op\s+"
        }

        $canProcess = ($parts | ForEach-Object { $wires.ContainsKey($_) -or $_ -match '^\d+$' }) -notcontains $false
        if (-not $canProcess) {
            return $false
        }

        $opArgs = $parts | ForEach-Object {
            if ($_ -match '^\d+$') { [UInt16]$_ } else { [Uint16]$wires[$_] }
        }

        $result = & $operationMap[$regexMatch.Value] @opArgs
    }
    else {
        if ($operation -match '^\d+$') {
            $result = [UInt16]$operation
        }
        elseif ($wires.ContainsKey($operation)) {
            $result = [Uint16]$wires[$operation]
        }
        else {
            return $false
        }
    }

    $wires[$wire] = [UInt16]$result
    return $true
}

$script:wires = @{}
$processingQueue = [System.Collections.Queue]::new($puzzleInput)
$delayedQueue = [System.Collections.Generic.List[string]]::new()
while ($processingQueue.Count -gt 0 -or $delayedQueue.Count -gt 0) {
    $itemProcessed = $false

    # Process delayed queue first
    if ($delayedQueue.Count -gt 0) {
        for ($i = 0; $i -lt $delayedQueue.Count; $i++) {
            if (Resolve-WireValue -Instruction $delayedQueue[$i]) {
                $itemProcessed = $true
                $delayedQueue.RemoveAt($i)
                break
            }
        }
    }

    # Start over if an item in the delayed queue was processed
    if ($itemProcessed) {
        continue
    }

    # Process main queue
    if ($processingQueue.Count -gt 0) {
        $thisInstruction = $processingQueue.Dequeue()
        if (-not (Resolve-WireValue -Instruction $thisInstruction)) {
            $delayedQueue.Add($thisInstruction)
        }
        continue
    }

    # No progress made
    if (-not $itemProcessed) {
        throw 'Cannot continue due to circular dependency or unresolved inputs.'
    }
}

Write-Host ('Wire Signal on a: {0}' -f $wires['a']) -ForegroundColor Green

#endregion

#region Part 2
$instructionMap = @{}
foreach ($instruction in $puzzleInput) {
    $instructionMap[($Instruction -split ' -> ')[1]] = $instruction
}

# Override the b wire
$instructionMap['b'] = '{0} -> b' -f $wires['a']

# Reset all wires and reprocess
$script:wires = @{}
$processingQueue = [System.Collections.Queue]::new($instructionMap.Values)
$delayedQueue = [System.Collections.Generic.List[string]]::new()
while ($processingQueue.Count -gt 0 -or $delayedQueue.Count -gt 0) {
    $itemProcessed = $false

    # Process delayed queue first
    if ($delayedQueue.Count -gt 0) {
        for ($i = 0; $i -lt $delayedQueue.Count; $i++) {
            if (Resolve-WireValue -Instruction $delayedQueue[$i]) {
                $itemProcessed = $true
                $delayedQueue.RemoveAt($i)
                break
            }
        }
    }

    # Start over if an item in the delayed queue was processed
    if ($itemProcessed) {
        continue
    }

    # Process main queue
    if ($processingQueue.Count -gt 0) {
        $thisInstruction = $processingQueue.Dequeue()
        if (-not (Resolve-WireValue -Instruction $thisInstruction)) {
            $delayedQueue.Add($thisInstruction)
        }
        continue
    }

    # No progress made
    if (-not $itemProcessed) {
        throw 'Cannot continue due to circular dependency or unresolved inputs.'
    }
}

Write-Host ('Wire Signal on a after override: {0}' -f $wires['a']) -ForegroundColor Green

#endregion