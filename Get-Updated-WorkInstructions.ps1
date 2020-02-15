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

#declare variables

#Change Search Path to root folder to search
$searchPath = "~"

#Change days to number of days back you want to search for
$Days = 7


$date = Get-Date -Format "yyyyMMdd"
$csvFileName = "{0}_Updated-WorkInstruction_Report.csv" -f $date

$results = Get-Updated-WorkInstructions -Path $searchPath -Days $Days | Select-Object -Property name,LastWriteTime
Add-Content -Path $PSScriptRoot\$csvFileName -Value '"Work Instruction Document Name", "Date Modified"'
foreach($result in $results) { 
    $newline = "`"{0}`", `"{1}`"" -f $result.Name, $result.LastWriteTime.ToShortDateString()
    Add-Content -Path $PSScriptRoot\$csvFileName -Value $newline
}