Function Get-ArchiveBit {
    <#
    .SYNOPSIS
    Function to Check the Archive Bit of a file
    .DESCRIPTION
    Function checks to see if the files Archive Bit has been enabled. If so, it returns a $True or $False for the $Attribute value

    Code borrowed from - # http://blogs.technet.com/b/heyscriptingguy/archive/2011/01/27/use-powershell-to-toggle-the-archive-bit-on-files.aspx
    .PARAMETER filename
    Pass the full path of the filename to the Function.
    .EXAMPLE
    Get-ArchiveBit -filename <path-to-file>
    Retrive the Archive Bit of the file
    #>

    param (
        [string]$filename
    )

    If (!(Test-Path -Path $filename)) {
        Write-Output "File not found!!!"
        Break
    }

    $ArchiveBit = (Get-ItemProperty $filename).attributes -band [IO.FileAttributes]::Archive

    If ($ArchiveBit -ne 0) {
        Write-Output "Archive bit found!!!"
        $Attribute = $True
    } else {
        Write-Output "Archive bit not found!!!"
        $Attribute = $False
    }

    Return $Attribute
}
