# YamsLab | Azure & Active Directory PowerShell Automation

**MSSA Server & Cloud Administration — AZ-040 Project**

## Project Overview

This project demonstrates how PowerShell can automate common cloud administration and Active Directory tasks.

I built four automation scripts using Microsoft Azure and my personal YamsLab environment. The goal was to reduce repetitive administrative work, verify infrastructure health, and practice managing cloud and on-premises systems through scripting.

The project combines Azure resource management with remote administration of a Windows Server domain controller hosted on Proxmox.

## Lab Environment

| Component | Technology |
|---|---|
| Workstation | Windows 11 Pro |
| Server virtualization | Proxmox VE |
| Domain controller | Windows Server (DC01) |
| Active Directory domain | ad.yams.home |
| Cloud platform | Microsoft Azure |
| Scripting | PowerShell |
| Development tools | Visual Studio Code, Git |
| Administration tools | RSAT, Active Directory PowerShell module |

The Windows 11 workstation is not domain-joined. Active Directory administration is performed remotely using authenticated connections to the domain controller.

## Automation Scripts

### 01 — Azure Resource Group Automation

**File:** `Scripts/01-Azure-ResourceGroup.ps1`

Checks the active Azure subscription and creates a resource group named `rg-yamslab-mssa` in the East US region if it does not already exist.

**Result:** Successfully created the resource group and verified that running the script again does not create duplicates.

### 02 — Azure Resource Inventory

**File:** `Scripts/02-Azure-Inventory.ps1`

Retrieves Azure resource group and resource information and exports the results into CSV reports.

**Output:**
- `Reports/ResourceGroups.csv`
- `Reports/AzureResources.csv`

**Result:** Successfully inventoried the Azure subscription. At the time of testing, the environment contained one resource group and no deployed resources.

### 03 — Active Directory Health Check

**File:** `Scripts/03-AD-HealthCheck.ps1`

Performs four categories of checks against the Windows Server domain controller:

- Network connectivity
- DNS resolution
- LDAP connectivity on TCP port 389
- Critical service status: NTDS, DNS, Netlogon, and KDC

**Result:** All checks passed, including authenticated remote service monitoring.

### 04 — Active Directory User Provisioning

**File:** `Scripts/04-AD-UserProvisioning.ps1`

Automates the creation of a dedicated Active Directory organizational unit, two security groups, and three disabled test user accounts.

**Created objects:**

| Object type | Name |
|---|---|
| Organizational unit | MSSA-Lab |
| Security group | MSSA-IT |
| Security group | MSSA-Helpdesk |
| Test user | Alex Morgan |
| Test user | Jordan Taylor |
| Test user | Casey Rivera |

**Result:** All six objects were created successfully. A second execution confirmed that existing objects were detected without creating duplicates.

## Repository Structure

```text
AZ-040-Project/
├── README.md
├── .gitignore
├── Scripts/
│   ├── 01-Azure-ResourceGroup.ps1
│   ├── 02-Azure-Inventory.ps1
│   ├── 03-AD-HealthCheck.ps1
│   └── 04-AD-UserProvisioning.ps1
└── Reports/
    ├── AzureResources.csv
    └── ResourceGroups.csv
```

## Prerequisites

- Windows PowerShell with required modules
- Azure PowerShell (`Az.Accounts`, `Az.Resources`)
- An Azure subscription with appropriate resource permissions
- RSAT Active Directory PowerShell module
- A reachable Windows Server domain controller
- Authorized domain credentials for Active Directory operations
- Remote management connectivity and appropriate authentication configuration

The scripts use lab-specific domain names, resource names, and paths. These must be adjusted before using them in another environment.

## Security Considerations

Administrative credentials are requested interactively rather than hardcoded into scripts.

Active Directory test users are created in a disabled state, and project objects are organized within a dedicated lab OU.

The scripts are intended for authorized lab administration and should be reviewed and tested before being used in a production environment.

## Key Skills Demonstrated

- PowerShell scripting and automation
- Azure resource management
- Active Directory administration
- Remote Windows Server management
- Network and service health verification
- CSV reporting
- Error handling and conditional logic
- Idempotent automation
- Technical documentation and version control

## Future Improvements

- Add structured logging and timestamped reports
- Export Active Directory health results to CSV
- Add group membership automation
- Introduce parameterized configuration
- Add automated testing and improved error handling
- Extend monitoring to additional servers

## Project Outcome

This project gave me hands-on experience automating administrative tasks across both Microsoft Azure and my personal Windows Server lab.

It also reinforced the importance of troubleshooting, secure authentication, repeatable execution, and documenting technical work so that others can understand and reproduce it.
