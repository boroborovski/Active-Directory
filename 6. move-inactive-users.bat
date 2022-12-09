::Batch file that moves users that have been inactive for a year to a new OU.

for /f "Tokens=*" %%s in ('dsquery user -inactive 52 -limit 2500') do (
DSMOVE %%s -newparent "OU=InactiveUser,DC=your,DC=domain"
)