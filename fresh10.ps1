Set-ExecutionPolicy Bypass -Scope Process -Force;

Install-PackageProvider -Name NuGet -Force;
Install-Module -Name PSWindowsUpdate -Force;
Import-Module PSWindowsUpdate -Force;
Get-WindowsUpdate -AcceptAll -Install -IgnoreReboot
irm https://community.chocolatey.org/install.ps1 | iex
New-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name ShowSecondsInSystemClock -PropertyType dword -Value 1;
New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name VerboseStatus -PropertyType dword -Value 1;
