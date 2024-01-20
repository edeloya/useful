Set-ExecutionPolicy Bypass -Scope Process -Force;

Install-PackageProvider -Name NuGet -Force;
Install-Module -Name PSWindowsUpdate -Force;
Import-Module PSWindowsUpdate -Force;
Get-WindowsUpdate -AcceptAll -Install -IgnoreReboot
irm https://community.chocolatey.org/install.ps1 | iex
New-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name ShowSecondsInSystemClock -PropertyType dword -Value 1;
New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name VerboseStatus -PropertyType dword -Value 1;
New-Item -Path 'HKCU:\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\';
New-Item -Path 'HKCU:\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32';
