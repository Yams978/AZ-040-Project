# YamsLab Active Directory Health Check
# MSSA Server & Cloud Administration Project

$DomainController = "dc01.ad.yams.home"
$DomainName = "ad.yams.home"

Write-Host "=== YAMSLAB ACTIVE DIRECTORY HEALTH CHECK ===" -ForegroundColor Cyan

# ------------------------------------------------------------
# 1. DOMAIN CONTROLLER CONNECTIVITY
# ------------------------------------------------------------

Write-Host "`n[1] Domain Controller Connectivity"

try {
    $Ping = Test-Connection `
        -ComputerName $DomainController `
        -Count 2 `
        -Quiet `
        -ErrorAction Stop

    if ($Ping) {
        Write-Host "PASS: Domain controller is reachable." -ForegroundColor Green
    }
    else {
        Write-Host "FAIL: Domain controller is unreachable." -ForegroundColor Red
    }
}
catch {
    Write-Host "FAIL: Connectivity test failed - $($_.Exception.Message)" -ForegroundColor Red
}

# ------------------------------------------------------------
# 2. DNS RESOLUTION
# ------------------------------------------------------------

Write-Host "`n[2] DNS Resolution"

try {
    $DNS = Resolve-DnsName `
        -Name $DomainName `
        -Type A `
        -ErrorAction Stop

    Write-Host "PASS: Domain DNS resolved successfully." -ForegroundColor Green

    $DNS |
        Where-Object { $_.IPAddress } |
        Select-Object Name, IPAddress |
        Format-Table -AutoSize |
        Out-Host
}
catch {
    Write-Host "FAIL: DNS resolution failed - $($_.Exception.Message)" -ForegroundColor Red
}

# ------------------------------------------------------------
# 3. LDAP CONNECTIVITY
# ------------------------------------------------------------

Write-Host "`n[3] LDAP Connectivity"

try {
    $LDAP = Test-NetConnection `
        -ComputerName $DomainController `
        -Port 389 `
        -InformationLevel Quiet `
        -WarningAction SilentlyContinue

    if ($LDAP) {
        Write-Host "PASS: LDAP port 389 is reachable." -ForegroundColor Green
    }
    else {
        Write-Host "FAIL: LDAP port 389 is unreachable." -ForegroundColor Red
    }
}
catch {
    Write-Host "FAIL: LDAP test failed - $($_.Exception.Message)" -ForegroundColor Red
}


# Check Active Directory services remotely
Write-Host "`n[4] Active Directory Services"

$Services = @("NTDS", "DNS", "Netlogon", "KDC")
$Session = $null

try {
    # Request domain administrator credentials
    $Credential = Get-Credential -UserName "YAMSLAB\Administrator" `
        -Message "Enter DC01 administrator credentials"

    # Establish an authenticated connection
    $Session = New-CimSession `
        -ComputerName $DomainController `
        -Credential $Credential `
        -Authentication Negotiate `
        -ErrorAction Stop

    foreach ($Service in $Services) {
        try {
            $Result = Get-CimInstance `
                -CimSession $Session `
                -ClassName Win32_Service `
                -Filter "Name='$Service'" `
                -ErrorAction Stop

            if (-not $Result) {
                Write-Host "WARNING: $Service was not found." -ForegroundColor Yellow
            }
            elseif ($Result.State -eq "Running") {
                Write-Host "PASS: $Service is running." -ForegroundColor Green
            }
            else {
                Write-Host "FAIL: $Service status is $($Result.State)." -ForegroundColor Red
            }
        }
        catch {
            Write-Host "WARNING: Unable to check $Service - $($_.Exception.Message)" -ForegroundColor Yellow
        }
    }
}
catch {
    Write-Host "ERROR: Remote connection failed - $($_.Exception.Message)" -ForegroundColor Red
}
finally {
    if ($Session) {
        Remove-CimSession -CimSession $Session
    }
}

Write-Host "`n=== HEALTH CHECK COMPLETE ===" -ForegroundColor Cyan
