
# YamsLab Azure Resource Group Automation
# MSSA Server & Cloud Administration Project

$ResourceGroupName = "rg-yamslab-mssa"
$Location = "eastus"

Write-Host "=== YAMSLAB AZURE AUTOMATION ===" -ForegroundColor Cyan

# Verify Azure authentication
$Context = Get-AzContext

if (-not $Context) {
    Write-Host "ERROR: Not connected to Azure." -ForegroundColor Red
    exit 1
}

# Verify the intended subscription
$ExpectedSubscription = "MSSA August 2026_Michael_Yambo"

if ($Context.Subscription.Name -ne $ExpectedSubscription) {
    Write-Host "ERROR: Wrong Azure subscription selected." -ForegroundColor Red
    exit 1
}

Write-Host "Subscription verified: $ExpectedSubscription" -ForegroundColor Green

# Check whether the resource group exists
$ResourceGroup = Get-AzResourceGroup `
    -Name $ResourceGroupName `
    -ErrorAction SilentlyContinue

if ($ResourceGroup) {
    Write-Host "Resource group already exists: $ResourceGroupName" -ForegroundColor Yellow
}
else {
    Write-Host "Creating resource group: $ResourceGroupName"

    New-AzResourceGroup `
        -Name $ResourceGroupName `
        -Location $Location `
        -ErrorAction Stop

    Write-Host "Resource group created successfully!" -ForegroundColor Green
}

Write-Host "=== AUTOMATION COMPLETE ===" -ForegroundColor Cyan
