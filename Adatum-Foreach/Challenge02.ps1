#Name: Michael Yambo
# Challenge: 02
# Purpose: Build fully qualified domain names using foreach
# Run on: LON-CL1

$computers = @('LON-CL1', 'LON-DC2', 'LON-SVR1')
$Domain = 'Adatum.com'

foreach ($computer in $computers) {
    $fullName = "$computers.$domain"
    write-output $fullName
}