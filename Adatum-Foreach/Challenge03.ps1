# Name: Michael Yambo
# Challenge : 03
# Purpose: Check the status of local windows services
# Run on : LON-CL1

$serviceNames = @('EventLog', 'W32Time', 'spooler')

foreach ($name in $serviceNames) {
    $service = get-service -name $name
    write-output "$($service.name): $($service.Status)"
}
