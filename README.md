# powershell-examples

## Scheduled Tasks

There are many ways of running powershell from task scheduler. Below is what I consider to be the most reliable least admin method 

powershell.exe -File "path to file" -NoLogo -Noninteractive -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden