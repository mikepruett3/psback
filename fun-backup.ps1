
# http://blogs.technet.com/b/heyscriptingguy/archive/2011/01/27/use-powershell-to-toggle-the-archive-bit-on-files.aspx
Function Get-ArchiveBit {
    <#
    .SYNOPSIS
    Function to Check the Archive Bit of a file
    .DESCRIPTION
    Function checks to see if the files Archive Bit has been enabled. If so, it returns a $True or $False for the $Attribute value
    .PARAMETER <name>
    1st Parameter
    
    .PARAMETER <name>
    2nd Parameter
    
    .EXAMPLE
    Example of Parameter 1
    
    .\<ScriptName>.ps1 -<name>
    
    .EXAMPLE
    Example of Parameter 2
    
    .\<ScriptName>.ps1 -<name>
    #>

    param (
        [string]$filename
    )

    If (!(Test-Path -Path $filename)) {
        Write-Host "File not found!!!"
        break
    }

    $ArchiveBit = (Get-ItemProperty $filename).attributes -band [IO.FileAttributes]::Archive

    If ($ArchiveBit -ne 0) {
        Write-Host "Archive bit found!!!"
        $Attribute = $True
    } else {
        Write-Host "Archive bit not found!!!"
        $Attribute = $False
    }

    Return $Attribute
}
