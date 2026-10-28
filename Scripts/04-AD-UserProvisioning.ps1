
# ============================================================
# YAMSLAB ACTIVE DIRECTORY USER PROVISIONING
# MSSA Server & Cloud Administration Project
# ============================================================
# Creates a dedicated OU, test users, and security groups.
# Safe to rerun without creating duplicate objects.
# ============================================================

$DomainController = "dc01.ad.yams.home"
$DomainName = "ad.yams.home"
$DomainDN = "DC=ad,DC=yams,DC=home"
$OUName = "MSSA-Lab"
$OUPath = "OU=$OUName,$DomainDN"

$Users = @(
    @{ FirstName = "Alex"; LastName = "Morgan"; Username = "alex.morgan" },
    @{ FirstName = "Jordan"; LastName = "Taylor"; Username = "jordan.taylor" },
    @{ FirstName = "Casey"; LastName = "Rivera"; Username = "casey.rivera" }
)

$Groups = @(
    "MSSA-IT",
    "MSSA-Helpdesk"
)

Write-Host "`n=== YAMSLAB AD USER PROVISIONING ===" -ForegroundColor Cyan

Import-Module ActiveDirectory -ErrorAction Stop

$Credential = Get-Credential `
    -UserName "YAMSLAB\Administrator" `
    -Message "Enter DC01 administrator credentials"

# Create the lab OU if necessary
$ExistingOU = Get-ADOrganizationalUnit `
    -Filter "Name -eq '$OUName'" `
    -SearchBase $DomainDN `
    -Server $DomainController `
    -Credential $Credential `
    -ErrorAction Stop

if (-not $ExistingOU) {
    New-ADOrganizationalUnit `
        -Name $OUName `
        -Path $DomainDN `
        -ProtectedFromAccidentalDeletion $true `
        -Server $DomainController `
        -Credential $Credential `
        -ErrorAction Stop

    Write-Host "CREATED: OU $OUName" -ForegroundColor Green
}
else {
    Write-Host "EXISTS: OU $OUName" -ForegroundColor Yellow
}

# Create security groups
foreach ($GroupName in $Groups) {
    $ExistingGroup = Get-ADGroup `
        -Filter "SamAccountName -eq '$GroupName'" `
        -SearchBase $OUPath `
        -Server $DomainController `
        -Credential $Credential `
        -ErrorAction Stop

    if (-not $ExistingGroup) {
        New-ADGroup `
            -Name $GroupName `
            -SamAccountName $GroupName `
            -GroupScope Global `
            -GroupCategory Security `
            -Path $OUPath `
            -Server $DomainController `
            -Credential $Credential `
            -ErrorAction Stop

        Write-Host "CREATED: Group $GroupName" -ForegroundColor Green
    }
    else {
        Write-Host "EXISTS: Group $GroupName" -ForegroundColor Yellow
    }
}

# Create disabled test users (no password required)
foreach ($User in $Users) {
    $Username = $User.Username
    $FullName = "$($User.FirstName) $($User.LastName)"

    $ExistingUser = Get-ADUser `
        -Filter "SamAccountName -eq '$Username'" `
        -SearchBase $OUPath `
        -Server $DomainController `
        -Credential $Credential `
        -ErrorAction Stop

    if (-not $ExistingUser) {
        New-ADUser `
            -Name $FullName `
            -GivenName $User.FirstName `
            -Surname $User.LastName `
            -SamAccountName $Username `
            -UserPrincipalName "$Username@$DomainName" `
            -Path $OUPath `
            -Enabled $false `
            -Server $DomainController `
            -Credential $Credential `
            -ErrorAction Stop

        Write-Host "CREATED: User $FullName (disabled)" -ForegroundColor Green
    }
    else {
        Write-Host "EXISTS: User $FullName" -ForegroundColor Yellow
    }
}

Write-Host "`n=== PROVISIONING COMPLETE ===" -ForegroundColor Cyan
