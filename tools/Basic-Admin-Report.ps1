Get-CimInstance -ClassName Win32_ComputerSystem
Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object Name, Manufacturer, Model
Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object Name, Manufacturer, Model, Domain

$computerSystem = Get-CimInstance -ClassName Win32_ComputerSystem
$computerSystem | Format-List Name, Manufacturer, Model, Domain

$bios = Get-CimInstance -ClassName Win32_BIOS
$bios | Format-List Manufacturer, SMBIOSBIOSVersion, ReleaseDate, SerialNumber

$cpu = Get-CimInstance -ClassName Win32_Processor
$cpu | Format-List Name, NumberOfCores, NumberOfLogicalProcessors

$system = Get-CimInstance -ClassName Win32_ComputerSystem
$system

$system.Name
$system.Model

$system | Select-Object Name, Model

$system | Get-Member -MemberType Property

$system.NumberOfLogicalProcessors

$computerReport = $system |
    Select-Object Name, Manufacturer, Model, Domain,
        NumberOfLogicalProcessors
$computerReport

$bios = Get-CimInstance -ClassName Win32_BIOS
$bios

$bios.Manufacturer
$bios.SMBIOSBIOSVersion
$bios.SerialNumber

$biosReport = $bios |
    Select-Object Manufacturer, SMBIOSBIOSVersion, SerialNumber
$biosReport

$reportProperties = @{
    ComputerName      = $system.Name
    Manufacturer      = $system.Manufacturer
    Model             = $system.Model
    Domain            = $system.Domain
    LogicalProcessors = $system.NumberOfLogicalProcessors
    BIOSManufacturer  = $bios.Manufacturer
    BIOSVersion       = $bios.SMBIOSBIOSVersion
BIOSReleaseDate = $bios.ReleaseDate
    SerialNumber      = $bios.SerialNumber
}
$reportProperties

$reportProperties['ComputerName']

$adminReport = [pscustomobject]$reportProperties
$adminReport

$adminReport | Get-Member -MemberType NoteProperty
$adminReport.ComputerName
$adminReport | Select-Object ComputerName, Model, BIOSVersion

$reportFolder = $env:USERPROFILE
$reportFolder

$adminReport | Export-Csv "$reportFolder\AdminReport.csv" -NoTypeInformation

Import-Csv "$reportFolder\AdminReport.csv"
$bios.ReleaseDate