#Script that manipulates the registry to downgrade windows 10 pro to windows 10 home
#Really useful when imaging devices with pro to devices with home, as swapping product keys often doesn't work
#After you run this, run an upgrade install via a windows image matching your version of windows, and voila!
#This script was created 17/5/19, I can't guarentee it will work in the future, this is just how windows works right now

#Written by Michael Condon

Write-Host "This script will manipulate registry values to downgrade your version of Windows 10 Pro to Windows 10 Home"
Write-Host "Please only use this script if you have a valid license for Windows 10 Home, otherwise windows will not reactivate"
Write-Host "This script was created 17/5/19, I can't guarantee it will work in the future, this is just how windows works right now"
Write-Host "Once this script succesfully runs, please run an upgrade install from a windows image, either the same version or a newer version than what you are currently running"
Read-Host "Please press enter to continue, if you are unsure, simply close the script" -ForegroundColor "red"


Set-Itemproperty -path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name 'CompositionEditionID' -Value 'Core'
Set-Itemproperty -path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name 'Edition ID' -Value 'Core'
Set-Itemproperty -path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name 'InstallationID' -Value 'Client'
Set-Itemproperty -path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name 'ProductName' -Value 'Windows 10 Home'
#You have to change these valus in two locations, I guess.
Set-Itemproperty -path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion' -Name 'CompositionEditionID' -Value 'Core'
Set-Itemproperty -path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion' -Name 'Edition ID' -Value 'Core'
Set-Itemproperty -path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion' -Name 'InstallationID' -Value 'Client'
Set-Itemproperty -path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion' -Name 'ProductName' -Value 'Windows 10 Home'