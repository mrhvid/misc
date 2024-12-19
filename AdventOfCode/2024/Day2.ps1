<#
The levels are either all increasing or all decreasing.
Any two adjacent levels differ by at least one and at most three.
In the example above, the reports can be found safe or unsafe by checking those rules:

7 6 4 2 1: Safe because the levels are all decreasing by 1 or 2.
1 2 7 8 9: Unsafe because 2 7 is an increase of 5.
9 7 6 2 1: Unsafe because 6 2 is a decrease of 4.
1 3 2 4 5: Unsafe because 1 3 is increasing but 3 2 is decreasing.
8 6 4 4 1: Unsafe because 4 4 is neither an increase or a decrease.
1 3 6 7 9: Safe because the levels are all increasing by 1, 2, or 3.
#>

Get-Content -Path day2-test.txt | ForEach-Object {
    $List = $_.Split(' ') | ForEach-Object {[int]$_}
    $Safe = $true
    $OnlyIncreasing = $false
    $OnlyDecreasing = $false

    # Check if the levels are all increasing or all decreasing
    for ($i = 0; $i -lt $List.Count - 1; $i++) {
        if ($List[$i] -gt $List[$i + 1]) {
            if($OnlyIncreasing) {
                $Safe = $false
                break
            }
            $OnlyDecreasing = $true
        } elseif ($List[$i] -lt $List[$i + 1]) {
            if($OnlyDecreasing) {
                $Safe = $false
                break
            }
            $OnlyIncreasing = $true
        } elseif ($List[$i] -eq $List[$i + 1]) {
            $Safe = $false
            break
        }
    }

    for ($i = 0; $i -lt $List.Count - 1; $i++) {
        $Diff = $List[$i] - $List[$i + 1]
        if ($Diff -lt -3 -or $Diff -gt 3) {
            $Safe = $false
            break
        }
    }
    if ($Safe) {
        return 1
    } else {
        return 0
    }
} | Measure-Object -Sum 

#Second half of the puzzle
<#
The engineers are surprised by the low number of safe reports until they realize they forgot to tell you about the Problem Dampener.

The Problem Dampener is a reactor-mounted module that lets the reactor safety systems tolerate a single bad level in what would otherwise be a safe report. It's like the bad level never happened!

Now, the same rules apply as before, except if removing a single level from an unsafe report would make it safe, the report instead counts as safe.

More of the above example's reports are now safe:

7 6 4 2 1: Safe without removing any level.
1 2 7 8 9: Unsafe regardless of which level is removed.
9 7 6 2 1: Unsafe regardless of which level is removed.
1 3 2 4 5: Safe by removing the second level, 3.
8 6 4 4 1: Safe by removing the third level, 4.
1 3 6 7 9: Safe without removing any level.
Thanks to the Problem Dampener, 4 reports are actually safe!

Update your analysis by handling situations where the Problem Dampener can remove a single level from unsafe reports. How many reports are now safe?
#>

$List = (Get-Content -Path day2-test.txt)[0] | %{ $_.Split(' ') | ForEach-Object {[int]$_} }

Get-Content -Path day2.txt | ForEach-Object {
    $List = $_.Split(' ') | ForEach-Object {[int]$_}
    $Safe = $false

    # Function to check if the list is strictly increasing or decreasing
    function Is-Safe($arr) {
        if ($arr.Count -le 1) { return $true }

        $increasing = $true
        $decreasing = $true

        for ($i = 0; $i -lt $arr.Count - 1; $i++) {
            $diff = $arr[$i + 1] - $arr[$i]
            if ($diff -le 0) { $increasing = $false }
            if ($diff -ge 0) { $decreasing = $false }
            if ([Math]::Abs($diff) -lt 1 -or [Math]::Abs($diff) -gt 3) {
                return $false
            }
        }
        return $increasing -or $decreasing
    }

    # Check if the original list is safe
    if (Is-Safe $List) {
        $Safe = $true
    }
    else {
        # Attempt to remove one element to make the list safe
        for ($i = 0; $i -lt $List.Count; $i++) {
            if ($i -eq 0) {
                $tempList = $List[1..($List.Count - 1)]
            }
            elseif ($i -eq ($List.Count - 1)) {
                $tempList = $List[0..($List.Count - 2)]
            }
            else {
                $tempList = $List[0..($i - 1)] + $List[($i + 1)..($List.Count - 1)]
            }

            if (Is-Safe $tempList) {
                $Safe = $true
                break
            }
        }
    }

    if ($Safe) {
  #      Write-Host "Safe"
        return 1
    }
    else {
 #       Write-Host "Unsafe"
        return 0
    }
} | Measure-Object -Sum