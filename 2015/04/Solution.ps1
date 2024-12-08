# https://adventofcode.com/2015/day/4

#region Part 1

$puzzleInput = Get-Content -Path '.\input.txt'

try {
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    $md5 = [System.Security.Cryptography.MD5]::Create()
    $result = 0
    while ($true) {
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
    Write-Host ('Lowest Positive Number: {0}' -f $result) -ForegroundColor Green
    Write-Host "Elapsed Time: $($stopwatch.ElapsedMilliseconds) ms"
    Write-Host "Actions Performed: $result"
}

#endregion

#region Part 2



Write-Host ('Total Ribbon Required: {0}' -f $result) -ForegroundColor Green
#endregion