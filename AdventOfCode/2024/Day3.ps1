
# find all instances of mul(X,Y) in the input file and sum the results

$matches = Select-String -Path .\Day3.txt -Pattern 'mul\((\d+),(\d+)\)' -AllMatches

# Calculate the sum of the results of matches in the input file
$sum = 0
foreach ($match in $matches.Matches) {
    $sum += [int]$match.Groups[1].Value * [int]$match.Groups[2].Value
}


# Second part of the puzzle
# Look for 'do()' instruction enables future mul instructions. 
# Look for 'don't()' instruction disables future mul instructions.

$instructions = Select-String -Path .\Day3.txt -Pattern 'mul\((\d+),(\d+)\)|do\(\)|don''t\(\)' -AllMatches

$mulEnabled = $true
$sum = 0
foreach ($instruction in $instructions.Matches) {
    if ($instruction -match "do\(\)") {
        $mulEnabled = $true
    }
    elseif ($instruction -match "don\'t\(\)") {
        $mulEnabled = $false
    }
    elseif ($instruction -match "mul\((\d+),(\d+)\)") {
        if ($mulEnabled) {
            $sum += [int]$instruction.Groups[1].Value * [int]$instruction.Groups[2].Value
            #$sum += [int]$matches.Matches[0].Groups[1].Value * [int]$matches.Matches[0].Groups[2].Value
        }
    }
}
$sum