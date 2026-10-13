# Name: Michael Yambo
# Challenger: 01
# Purpose : List the lab computers using foreach
# Run on : LON-CL1

$computers = @('LON-CL1', 'LON-DC1', 'LON-SVR1')

foreach ($computer in $computers) {
    Write-output "computer: $computer"
}