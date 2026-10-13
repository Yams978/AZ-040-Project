# Name: Michael Yambo
# Challenge: 04
# Purpose: count all local windows services
# Run On: LON-CL1

$services = @(get-service)
$total = 0

foreach ($service in $services) {
    write-output $service.name
    $total = $total + 1
}
write-output "total services: $total"
@(Get-Service).count