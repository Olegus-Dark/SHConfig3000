Set-ExecutionPolicy Unrestricted -Force
function Disable-Indexing 
{
    Param($Drive)
    $obj = Get-WmiObject -Class Win32_Volume -Filter "DriveLetter='$Drive'"
    $indexing = $obj.IndexingEnabled
    if("$indexing" -eq $True)
	{
        write-host "Disabling indexing of drive $Drive"
        $obj | Set-WmiInstance -Arguments @{IndexingEnabled=$False} | Out-Null
    }
}

Disable-Indexing "C:"
Disable-Indexing "D:"
Disable-Indexing "E:"
Disable-Indexing "F:"
Disable-Indexing "G:"