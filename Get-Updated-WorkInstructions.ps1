

function Get-Updated-WorkInstructions {
[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $Path,
    [string]
    $Days
)

    Get-ChildItem *.doc* -Path $Path -Recurse  | Where-Object {!$_.psiscontainer} | Where-Object {$_.LastWriteTime -gt (Get-Date).AddDays(-$Days)}
}


#Change Path and Days 
$results = Get-Updated-WorkInstructions -Path . -Days 7 | Select-Object -Property name,LastWriteTime
Add-Content -Path .\Updated-WorkInstructions.csv -Value '"Work Instruction Document Name", "Date Modified"'
foreach($result in $results) { 
    $newline = "`"{0}`", `"{1}`"" -f $result.Name, $result.LastWriteTime.ToShortDateString()
    Add-Content -Path .\Updated-WorkInstructions.csv -Value $newline
}