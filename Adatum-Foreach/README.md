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

**Validation:** The script displayed all three computer names in the correct order using a foreach loop.

**Reflection:** `$computers` contains the entire collection of computer names. `$computer` contains one computer name at a time.

---

## Challenge 02 — Build Domain-Qualified Names

**Run Location:** LON-CL1  
**Script:** Challenge02.ps1

**Observed Result:**

```text
LON-CL1.Adatum.com
LON-DC1.Adatum.com
LON-SVR1.Adatum.com
```

**Validation:** The script displayed all three fully qualified domain names in the correct order using a foreach loop.

**Reflection:** Printing a domain name does not prove the computer is reachable. The script only combines text and does not test connectivity.

---

## Challenge 03 — Inspect Local Services

**Run Location:** LON-CL1  
**Script:** Challenge03.ps1

**Observed Result:**

```text
EventLog: Running
W32Time: Running
Spooler: Running
```

**Validation:** The script successfully checked all three Windows services using Get-Service inside a foreach loop.

**Reflection:** Service statuses can differ because computers may have different configurations, startup settings, or currently running services.

---

## Challenge 04 — Count Local Services

**Run Location:** LON-CL1  
**Script:** Challenge04.ps1

**Observed Result:**

```text
Total services: 256
```

**Validation:** The foreach loop counted 256 services. I verified the result using `$services.Count`, which also returned 256.

**Reflection:** Resetting the counter inside the loop would cause it to start over on every iteration, preventing an accurate total.

