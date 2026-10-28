
# YamsLab Azure Resource Inventory
# MSSA Server & Cloud Administration Project

$ExpectedSubscription = "MSSA August 2026_Michael_Yambo"
$ReportFolder = Join-Path $PSScriptRoot "..\Reports"

Write-Host "=== YAMSLAB AZURE INVENTORY ===" -ForegroundColor Cyan

# Verify Azure connection
$Context = Get-AzContext

if (-not $Context) {
    Write-Host "ERROR: Not connected to Azure." -ForegroundColor Red
    return
}

# Verify subscription
if ($Context.Subscription.Name -ne $ExpectedSubscription) {
    Write-Host "ERROR: Incorrect Azure subscription." -ForegroundColor Red
    return
}

Write-Host "Connected to: $ExpectedSubscription" -ForegroundColor Green

# Create Reports folder
if (-not (Test-Path $ReportFolder)) {
    New-Item -Path $ReportFolder -ItemType Directory | Out-Null
}

# Retrieve resource groups
$ResourceGroups = @(Get-AzResourceGroup -ErrorAction Stop)

$ResourceGroups |
    Select-Object ResourceGroupName, Location, ProvisioningState |
    Export-Csv "$ReportFolder\ResourceGroups.csv" -NoTypeInformation

Write-Host "Resource groups found: $($ResourceGroups.Count)"

# Retrieve Azure resources
$Resources = @(Get-AzResource -ErrorAction Stop)

if ($Resources.Count -gt 0) {
    $Resources |
        Select-Object Name, ResourceType, ResourceGroupName, Location |
        Export-Csv "$ReportFolder\AzureResources.csv" -NoTypeInformation
}
else {
    "Name,ResourceType,ResourceGroupName,Location" |
        Set-Content "$ReportFolder\AzureResources.csv"
}

Write-Host "Azure resources found: $($Resources.Count)"
Write-Host "Reports saved to: $ReportFolder" -ForegroundColor Green
Write-Host "=== INVENTORY COMPLETE ===" -ForegroundColor Cyan
