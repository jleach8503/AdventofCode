# https://adventofcode.com/2015/day/4

#region Part 1

$puzzleInput = Get-Content -Path '.\input.txt'

try {
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    $md5 = [System.Security.Cryptography.MD5]::Create()
    $result = 0
    while ($true) {
        Write-Host ("Currently processing: {0}`r" -f $result) -NoNewline
        $secretKey = $puzzleInput + $result
        $byteArray = [System.Text.Encoding]::UTF8.GetBytes($secretKey)
        $hashBytes = $md5.ComputeHash($byteArray)
        $hashResult = ($hashBytes | ForEach-Object { $_.ToString('x2') }) -join ''
        if ($hashResult.Substring(0,5) -eq '00000') {
            break
        }
        $result++
    }
}
finally {
    Write-Host ('Lowest Positive Number with 5 zeros: {0}' -f $result) -ForegroundColor Green
    Write-Host "Elapsed Time: $($stopwatch.ElapsedMilliseconds) ms"
    Write-Host "Actions Performed: $result"
    $stopwatch.Stop()
}

#endregion

#region Part 2
try {
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    Clear-Host
    while ($true) {
        if ($result % 100000 -eq 0) {
            Write-Host ("`rCurrently processing: {0}" -f $result) -NoNewline
        }
        $secretKey = [System.String]::Concat($puzzleInput,$result)
        $byteArray = [System.Text.Encoding]::UTF8.GetBytes($secretKey)
        $hashBytes = $md5.ComputeHash($byteArray)
        $isMatch = ($hashBytes[0] -eq 0 -and $hashBytes[1] -eq 0 -and $hashBytes[2] -eq 0)
        if ($isMatch) {
            Write-Host ''
            break
        }
        $result++
    }
}
finally {
    Write-Host ('Lowest Positive Number with 6 zeros: {0}' -f $result) -ForegroundColor Green
    Write-Host "Elapsed Time: $($stopwatch.ElapsedMilliseconds) ms"
    Write-Host "Actions Performed: $result"
    $stopwatch.Stop()
}
#endregion