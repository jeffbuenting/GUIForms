# --------------------------------------------------------------------------------

Function New-GUIForm {
    
<#
    .Synopsis
        Creates a new Gui Form

    .Description
        Creates a new Gui Form Window.  Once the windows object is created, different textboxes and buttons can be added.  Primarily used for input.

    .Link
        https://sysadminemporium.wordpress.com/2012/11/26/powershell-gui-front-end-for-your-scripts-episode-1/

#>

    [CmdletBinding()]
    Param (
        [Parameter ( Mandatory = $True )]
        [String]$Length,
        
        [Parameter ( Mandatory = $True )]
        [String]$Width
    )

    Begin {
       # [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
       # [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")  #loading the necessary .net libraries (using void to suppress output)
    }

    Process {

        $Form = New-Object System.Windows.Forms.Form    #creating the form (this will be the "primary" window)
        $Form.Size = New-Object System.Drawing.Size($Length,$Width)  #the size in px of the window length, height

        $Form.Add_Shown({$Form.Activate()})

        Write-output $Form
    }
}

# --------------------------------------------------------------------------------
# --------------------------------------------------------------------------------
# --------------------------------------------------------------------------------
# --------------------------------------------------------------------------------
# --------------------------------------------------------------------------------
# --------------------------------------------------------------------------------
