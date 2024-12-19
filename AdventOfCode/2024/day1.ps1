# Create a function for day 1 of advent of code
# Calculate the disance between two lists
# 
<#
3   4
4   3
2   5
1   3
3   9
3   3

Each list should be sorted and then compare the length between each number starting with smallest on each list. Then summ all the differences. 
#>
function Get-Distance {
    param(
        [int[]]$List1,
        [int[]]$List2
    )
    $List1 = $List1 | Sort-Object
    $List2 = $List2 | Sort-Object
    $Distance = 0
    for ($i = 0; $i -lt $List1.Count; $i++) {
        $Distance += [Math]::Abs($List1[$i] - $List2[$i])
    }
    $Distance
}

# function to calculate simularity score
<#
Here are the same example lists again:

3   4
4   3
2   5
1   3
3   9
3   3
For these example lists, here is the process of finding the similarity score:

The first number in the left list is 3. It appears in the right list three times, so the similarity score increases by 3 * 3 = 9.
The second number in the left list is 4. It appears in the right list once, so the similarity score increases by 4 * 1 = 4.
The third number in the left list is 2. It does not appear in the right list, so the similarity score does not increase (2 * 0 = 0).
The fourth number, 1, also does not appear in the right list.
The fifth number, 3, appears in the right list three times; the similarity score increases by 9.
The last number, 3, appears in the right list three times; the similarity score again increases by 9.
So, for these example lists, the similarity score at the end of this process is 31 (9 + 4 + 0 + 0 + 9 + 9).
#>

function Get-Similarity {
    param(
        [int[]]$List1,
        [int[]]$List2
    )
    $List1 = $List1 | Sort-Object
    $List2 = $List2 | Sort-Object
    $Similarity = 0
    for ($i = 0; $i -lt $List1.Count; $i++) {
        $Similarity += $List1[$i] * ($List2 | Where-Object {$_ -eq $List1[$i]}).Count
    }
    $Similarity
}




$Lists = Get-Content -Path .\Day1.txt | %{$_.replace('   ', ',').Trim()} | 
        ConvertFrom-Csv -Header List1, List2 -Delimiter ','

$List1 = $Lists.List1
$List2 = $Lists.List2

Get-Distance -List1 $List1 -List2 $List2

Get-Similarity -List1 $List1 -List2 $List2