Set-ExecutionPolicy Bypass -Scope Process -Force;
Install-PackageProvider -Name NuGet -Force;
Install-Module -Name PSWindowsUpdate -Force;
Import-Module PSWindowsUpdate -Force;
Get-WindowsUpdate -AcceptAll -Install -IgnoreReboot
irm https://community.chocolatey.org/install.ps1 | iex
