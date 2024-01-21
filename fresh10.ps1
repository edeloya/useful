#Allow this script to bypass default ExecutionPolicy
Set-ExecutionPolicy Bypass -Scope Process -Force;

#Install reqs for and runs PSWindowsUpdate 
Install-PackageProvider -Name NuGet -Force;
Install-Module -Name PSWindowsUpdate -Force;
Import-Module PSWindowsUpdate -Force;
Get-WindowsUpdate -AcceptAll -Install -IgnoreReboot

#Installs Choco
irm https://community.chocolatey.org/install.ps1 | iex

#Clock setting Show Seconds
New-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name ShowSecondsInSystemClock -PropertyType dword -Value 1;

#Verbose OS status messages
New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name VerboseStatus -PropertyType dword -Value 1;

#Old Context Menu
New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Value "" -Force;
