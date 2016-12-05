function Save-Button {

     Write-Host "Check1-Click, mach was.. " 
    $CRMServer = $CRMServerInput.Text

    Write-Host "Save : $CRMServer"

    $Form.Close()
}



[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")  #loading the necessary .net libraries (using void to suppress outpu

import-module F:\GitHub\GUIForms\GuiForms.psd1 -force 

$Form = New-GUIForm -Length 600 -Width 400

$CRMServerInput = New-GUIFormInputBox -Form ([Ref]$Form) -x 20 -Y 50 -Length 150 -Height 20 -Title "CRMServer" -verbose

$SaveButton  = { 
    Write-Host "Check1-Click, mach was.. " 
    $CRMServer = $CRMServerInput.Text
    Test
    $Form.Close()
}

New-GUIFormButton -Form $Form -X 400 -y 30 -Length 110 -Height 80 -Label 'Save' -Execute {Save-Button }


$Form.add_Shown({$Form.Activate()})
[void] $Form.ShowDialog()

$CRMServer
