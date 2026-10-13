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
