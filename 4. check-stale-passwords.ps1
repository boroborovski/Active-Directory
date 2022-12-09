#Powershell script that queries users that have not changed their password in the last 90 days.

$Days = 90
$Time = [DateTime]::Today.AddDays(-$Days)

Get-ADUser -Filter '(PasswordLastSet -lt $Time)' -Properties * | Select Name, PasswordLastSet | export-csv “C:\Temp\oldpasswords.csv"