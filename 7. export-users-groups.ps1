#Powershell scipt that queries and exports a list of users and their group memberships.

Get-ADUser -Filter * -SearchBase "OU=Users,DC=your,DC=domain" -Properties memberOf |
    Foreach-Object{
        # $_ represents a user object
        $var = [PSCustomObject]@{
                SID = $_.SamAccountName
                Name = $_.Name
                Group = ""
            }
        # create one row for each user/group combination
        $_.memberOf  |
            ForEach-Object{
                # $_ represents a group's distinguishedName
                $var.Group  = (Get-ADGroup $_).samaccountname
                $var
            }
        #  ---- OR ------
        # create one row for each user, all groups in "Group" column, each separated by ';'
        if ($_.memberOf){
            $groups = @()
            $_.memberOf |
                ForEach-Object{
                    $groups += (Get-ADGroup $_).samaccountname
                }
            $var.Group = $groups -join ';'
            $var
        }
    } | Export-Csv -Path C:\Temp\GrpMembers.csv -NoTypeInformation