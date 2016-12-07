function Save-Button {

     Write-Host "Check1-Click, mach was.. " 
    $CRMServer = $CRMServerInput.Text


    $Form.Close()

    return $CRMServer
}



[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")  #loading the necessary .net libraries (using void to suppress outpu

import-module F:\GitHub\GUIForms\GuiForms.psd1 -force 

$WinLength = 600
$WinHeight = 400

$Form = New-GUIForm -Title 'StratusLive Install' -Length $WinLength -Height $WinHeight

$ServerX = 10
$ServerY = 10
$Servers = New-GUIFormGroupBox -Form ([Ref]$Form) -Title "Servers" -X $ServerX -Y $ServerY -width 250 -Height 100
#$Form.Controls.Add($Servers)

$CRMServerInput = New-GUIFormInputBox -Form ([ref]$Servers) -x ($ServerX+5) -Y ($ServerY+10) -Length 150 -Height 20 -Title "CRM Server" -verbose
$SQLServerInput = New-GUIFormInputBox -Form ([Ref]$Servers) -x ($ServerX+5) -Y ($ServerY+35) -Length 150 -Height 20 -Title "SQL Server" -verbose
$ADFSServerInput = New-GUIFormInputBox -Form ([Ref]$Servers) -x ($ServerX+5) -Y ($ServerY+60) -Length 150 -Height 20 -Title "ADFS Server" -verbose

New-GUIFormButton -Form $Form -X ($Form.ClientRectangle.Width-120) -y ($Form.ClientRectangle.Height-60) -Length 110 -Height 50 -Label 'Save' -Execute { $Form.Close() }

$Form.add_Shown({$Form.Activate()})
[void] $Form.ShowDialog()

# ----- Get the Data after the save button clicked.

$CRMServer = $CRMServerInput.text
$SQLServer = $SQLServerInput.Text
$ADFSServer = $ADFSServerInput.Text

Write-Output "CRMServer = $CRMServer"
Write-Output "SQLServer = $SQLServer"

