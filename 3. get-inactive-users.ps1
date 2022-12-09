#Powershell script that queries inactive users and exports them to csv. Note that it queries only enabled users, unlike the batch script above. 

Import-module activedirectory

$domain = “your.domain”
$DaysInactive = 365
$time = (Get-Date).Adddays(-($DaysInactive))

#Get all AD User with lastLogonTimestamp less than our time and set to enable and Output Name and lastLogonTimestamp into CSV
Get-ADUser -Filter {LastLogonTimeStamp -lt $time -and enabled -eq $true} -Properties LastLogonTimeStamp | export-csv “C:\Temp\StaleUsers.CSV” –notypeinformation
