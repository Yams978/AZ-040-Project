
# AZ-040 - System Information Script

$computer = $env:COMPUTERNAME

$os = Get-CimInstance -ClassName Win32_OperatingSystem

$os.Caption
$os.LocalDateTime
$os.LastBootUpTime

$cDrive = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID='C:'"

$cDrive.DeviceID
$cDrive.Size
$cDrive.FreeSpace

[math]::Round($cDrive.Size / 1GB, 2)
[math]::Round($cDrive.FreeSpace / 1GB, 2)

$uptime = $os.LocalDateTime - $os.LastBootUpTime

$uptime.Days
$uptime.TotalHours
[math]::Round($uptime.TotalHours, 2)

$info = [PSCustomObject]@{
    Name            = $computer
    OS              = $os.Caption
    LocalTime       = $os.LocalDateTime
    LastBootUpTime  = $os.LastBootUpTime
    CDriveDeviceID  = $cDrive.DeviceID
    CDriveSize      = [math]::Round($cDrive.Size / 1GB, 2)
    CDriveFreeSpace = [math]::Round($cDrive.FreeSpace / 1GB, 2)
    UptimeDays      = $uptime.Days
    UptimeHours     = [math]::Round($uptime.TotalHours, 2)
}

$info | Format-Table -AutoSize

Get-Member -InputObject $info
