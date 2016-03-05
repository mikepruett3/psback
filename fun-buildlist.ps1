#Requires -Version 2.0

Function GetFileorFolderPath {
    <#
    .SYNOPSIS
    Function to Return the Path of a selected File or Folder
    .DESCRIPTION
    This function is expected to be called from another process to return the path of a desired file or folder.
    .PARAMETER option
    Used to select the appropriate Dialog for File or Folder selection
    .EXAMPLE
    GetFileorFolderPath -option file
    Open a file selection dialog and return the full path to the file
    .EXAMPLE
    GetFileorFolderPath -option folder
    Open a folder selection dialog and return the full path to the folder
    #>

    Param (
        [string]$option
    )

    # ----- Default Check for Parameters or the Required Parameteri -----
    if ( $psboundparameters.Count -eq 0 ) {
        Get-Help GetFileorFolderPath
        Break
    }

    Add-Type -AssemblyName System.Windows.Forms

    switch ($option) {
        # From  http://www.powershellmagazine.com/2013/07/01/pstip-using-the-system-windows-forms-openfiledialog-class/
        file    { $PathBrowser =  New-Object System.Windows.Forms.OpenFileDialog -Property @{
                                    Title = "Please Select a File"
                                    InitialDirectory = $Env:SystemDrive
                                    Filter = "All Files (*.*)|*.*"
                                    # Enable for Multiple Selections
                                    # MultiSelect = $True
                                }
                                $result = $PathBrowser.ShowDialog()
                                If ($result -eq "OK") {
                                    return $PathBrowser.FileNames
                                } else {
                                    return $NULL
                                }
                }
        # From  http://www.powershellmagazine.com/2013/06/28/pstip-using-the-system-windows-forms-folderbrowserdialog-class/
        folder  { $PathBrowser = New-Object System.Windows.Forms.FolderBrowserDialog -Property @{
                                    SelectedPath = $Env:SystemDrive
                                    ShowNewFolderButton = $True
                                }
                                $result = $PathBrowser.ShowDialog()
                                If ($result -eq "OK") {
                                    return $PathBrowser.SelectedPath
                                } else {
                                    return $NULL
                                }
                }
    }
}

While ( ($paths = GetFileorFolderPath -option folder ) -ne $NULL ) {
    $paths
}
