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

Function Add-GUIFormInputBox {
    
<# 
    .Synopsis
        Add a Text Inputbox to a Windows GUI Form

    .Description
        Add a text InputBox to a WIndows Gui Form

    .Parameter Form
        Windows Form to add the textbox

    .Parameter Title
        Title of the textbox

    .Parameter X
        Left coordinate in the Parent window Form

    .parameter Y
        Upper Coordinate in the Parent window Form

    .parameter Length
        Length of the input box

    .parameter Height
        Height of the Input Box

    .Example
        $Form = New-GUIWindow -Length 600 -Width 400

        $Form = Add-GUIFormTextBox -Form $Form -x 20 -Y 50 -Length 150 -Height 20 -Title "Testing" -verbose

        [void] $Form.ShowDialog() 

    .Link
        Text box form example
        https://sysadminemporium.wordpress.com/2012/11/26/powershell-gui-front-end-for-your-scripts-episode-1/

    .Link
        Textbox Class
        https://msdn.microsoft.com/en-us/library/system.windows.forms.textbox(v=vs.110).aspx

    .Link
        Label Class
        https://msdn.microsoft.com/en-us/library/system.windows.forms.label(v=vs.110).aspx

    .Note 
        Author : Jeff Buenting
        Date : 2016 DEC 02
#>

    [CmdletBinding()]
    Param (
        [Parameter ( Mandatory = $True )]
        [System.Windows.Forms.Form]$Form,

        [Parameter ( Mandatory = $True )]
        [int]$X,

        [Parameter ( Mandatory = $True )]
        [Int]$Y,

        [Parameter ( Mandatory = $True )]
        [Int]$Length,
        
        [Parameter ( Mandatory = $True )]
        [Int]$Height,

        [string]$Title
    )

    Process {

        # ----- Set the input box X value
        $InputX = $X

        # ----- Create a title TextBox
        if ( $Title ) {
            
             # ----- Move the x coordinate of the input field the length of the string
            # ----- https://social.technet.microsoft.com/Forums/SharePoint/en-US/3843ddcc-e326-4e5e-808c-59abd4d4dcea/find-the-length-of-a-string-in-pixels?forum=winserverpowershell
            $Font = New-Object System.Drawing.Font( $Form.Font.Name,$Form.Font.size )
            $Size = [System.WIndows.Forms.TextRenderer]::MeasureText($Title,$Font)
            $InputX += $Size.Width+5

            Write-Verbose "Setting Title = $Title"
            $TextTitle = New-Object System.Windows.Forms.Label 
            $TextTitle.Location = New-Object System.Drawing.Size($X,$Y)
            $TextTitle.Width = $Size.Width+5
            $TextTitle.Text = $Title
            $Form.Controls.Add($TextTitle)
           
        }

        Write-Verbose "Input Box X = $InputX"
        $InputBox = New-Object System.Windows.Forms.TextBox 
        $InputBox.Location = New-Object System.Drawing.Size($InputX,$Y) #location of the text box (px) in relation to the primary window's edges (length, height)
        $InputBox.Size = New-Object System.Drawing.Size($Length,$Height) #the size in px of the text box (length, height)
        #$InputBox.Text = "Hello"
        $Form.Controls.Add($InputBox) #activating the text box inside the Primary WIndow

        Write-Output $Form
    }
}

# --------------------------------------------------------------------------------
# --------------------------------------------------------------------------------
# --------------------------------------------------------------------------------
# --------------------------------------------------------------------------------
# --------------------------------------------------------------------------------
