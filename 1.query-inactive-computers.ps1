#This will query all of the inactive computers for the past year. The script creates a temp folder and outputs the result in a .csv file.

$DaysInactive = 365

mkdir -p C:\Temp

$time = (Get-Date).Adddays(-($DaysInactive))

Get-ADComputer -Filter {LastLogonTimeStamp -lt $time} -ResultPageSize 2500 -resultSetSize $null -Properties Name, OperatingSystem, SamAccountName, DistinguishedName | Export-CSV “C:\Temp\StaleComps.CSV” –NoTypeInformation


