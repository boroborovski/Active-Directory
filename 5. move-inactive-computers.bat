::Batch file that moves computers that have been inactive for a year to a new OU.

for /f "Tokens=*" %%s in ('dsquery computer -inactive 52 -limit 2500') do (
DSMOVE %%s -newparent "OU=InactivePC,DC=your,DC=domain"
)
