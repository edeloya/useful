PowerShell -NoProfile -ExecutionPolicy Bypass -Command "Get-WindowsUpdate -Download -AcceptAll -Install -IgnoreReboot;choco upgrade all -y"
PAUSE