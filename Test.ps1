
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")  #loading the necessary .net libraries (using void to suppress outpu

import-module F:\GitHub\GUIForms\GuiForms.psd1 -force 

$WinLength = 1000
$WinHeight = 400

$Form = New-GUIForm -Title 'StratusLive Install' -Length $WinLength -Height $WinHeight

# ----- Server Input
$ServerX = 10
$ServerY = 10
$Servers = New-GUIFormGroupBox -Form ([Ref]$Form) -Title "Servers" -X $ServerX -Y $ServerY -Length 250 -Height 100

$CRMServerInput = New-GUIFormInputBox -Form ([ref]$Form) -x ($ServerX+5) -Y ($ServerY+10) -Length 150 -Height 20 -Title "CRM Server" -verbose
$SQLServerInput = New-GUIFormInputBox -Form ([Ref]$Form) -x ($ServerX+5) -Y ($ServerY+35) -Length 150 -Height 20 -Title "SQL Server" -verbose
$ADFSServerInput = New-GUIFormInputBox -Form ([Ref]$Form) -x ($ServerX+5) -Y ($ServerY+60) -Length 150 -Height 20 -Title "ADFS Server" -verbose

# ----- Source Input
#$Sources = New-GUIFormGroupBox -Form ([Ref]$Form) -Title "Sources" -X ($ServerX+260) -Y $ServerY -Length 500 -Height 100

#$CRM2016ISOInput = New-GUIFormInputBox -Form ([ref]$Sources) -x (10) -Y (20) -Length 400 -Height 20 -Title "CRM 2016 ISO" -verbose
#$CRM2016ISOInput = New-GUIFormInputBox -Form ([ref]$Sources) -x (10) -Y (20) -Length 400 -Height 20 -Title "CRM 2016 ISO" -verbose

# ----- Buttons
New-GUIFormButton -Form $Form -X ($Form.ClientRectangle.Width-240) -y ($Form.ClientRectangle.Height-60) -Length 110 -Height 50 -Label 'Save' -Execute { 
    $CRMServer = $CRMServerInput.Text
    $Form.Close()
}
New-GUIFormButton -Form $Form -X ($Form.ClientRectangle.Width-120) -y ($Form.ClientRectangle.Height-60) -Length 110 -Height 50 -Label 'Cancel' -Execute { $Form.Close() }

####$Form.add_Shown({$Form.Activate()})
#[void] $Form.ShowDialog()
$DialogResult = Show-GUIForm ($Form)

# ----- Get the Data after the save button clicked.

#$CRMServer = $CRMServerInput.text
#$SQLServer = $SQLServerInput.Text
#$ADFSServer = $ADFSServerInput.Text

#$CRM2016Source = $CRM2016ISOInput.Text

Write-Output "CRMServer = $CRMServer"
Write-Output "SQLServer = $SQLServer"

