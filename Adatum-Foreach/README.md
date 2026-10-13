# Adatum PowerShell Foreach Challenges

## Challenge 01 — List the Lab Computers

**Run Location:** LON-CL1  
**Script:** Challenge01.ps1

**Observed Result:**
```text
Computer: LON-CL1
Computer: LON-DC1
Computer: LON-SVR1
```

**Validation:** The script successfully displayed all three computer names in the correct order using a foreach loop.

**Reflection:** `$computers` contains the entire collection of computer names. `$computer` contains one computer name at a time during each iteration of the loop.


Challenge 02 - Build Domain-Qualified Names
Run Location: LON-CL1
Script: Challenge02.ps1

Observed result:

LON-CL1.ADATUM.COM
LON-DC1.ADATUM.COM
LON-SVR1.ADATUM.COM

Validation: The script displayed all three fully qualified domain names in the correct order using a foreach loop.

Reflection: No, domain name does not prove that the computer is reachable. The script only combines the computer name with the domain name. It does not test network.


Challenge 03 - Inspect local services
Run Location: LON-CL1
Script : Challenge03.ps1

Observed result:

Eventlog: running
w32time: running
spooler: running

Validation: script successfully checked all three windows services using get-service inside a foreach loop. all three services running.

Reflection: service statuses can differ between other students because computers may have different settings startup config or services running at the time of check.
