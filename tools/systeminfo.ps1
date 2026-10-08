
# AZ-040 - System Information Script
# Get information about the local computer

$computer = $env:COMPUTERNAME

# Get operating system information
$os = Get-CimInstance -ClassName Win32_OperatingSystem

# Get C: drive information
$cDrive = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID='C:'"

# Calculate system uptime
$uptime = $os.LocalDateTime - $os.LastBootUpTime

# Create a custom object with system information
$info = [PSCustomObject]@{
    ComputerName      = $computer
    OS                = $os.Caption
    LastBootUpTime    = $os.LastBootUpTime
    CDriveSize        = $cDrive.Size
    CDriveFreeSpace   = $cDrive.FreeSpace
    CDriveFreeSpaceGB = [math]::Round($cDrive.FreeSpace / 1GB, 2)
    UptimeHours       = [math]::Round($uptime.TotalHours, 2)
}

# Display system information
$info
