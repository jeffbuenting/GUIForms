# --------------------------------------------------------------------------------

Function New-GuiForm {

<#
    .Synopsis
        Creates a new Gui Form

    .Description
        Creates a new Gui Form Window.  Once the windows object is created, different textboxes and buttons can be added.  Primarily used for input.

    .Parameter Length
        Length of the Window.

    .parameter Height
        Heigght of the Window.

    .Example
        Creates a new Form Window

        $Form = New-GuiForm -Title "Questionaire" -Length 300 -Height 500

    .Link
        https://sysadminemporium.wordpress.com/2012/11/26/powershell-gui-front-end-for-your-scripts-episode-1/

    .Notes
        Author : Jeff Buenting
        Date : 2017 JUN 23
#>

    [CmdletBinding()]
    Param (
        [String]$Title,

            [Parameter ( Mandatory = $True )]
            [String]$Length,
        
            [Parameter ( Mandatory = $True )]
            [String]$Height
    )

    Begin {
       # [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
       # [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")  #loading the necessary .net libraries (using void to suppress output)
    }

    Process {

        $Form = New-Object System.Windows.Forms.Form    #creating the form (this will be the "primary" window)
        $Form.Size = New-Object System.Drawing.Size($Length,$Height)  #the size in px of the window length, height
        $Form.Text = $Title

        #$Form.Add_Shown({$Form.Activate()})

        Write-output $Form
    }

}

# --------------------------------------------------------------------------------

Function New-GUIFormInputBox {
    
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
        Create a Input box called Testing

        $Form = New-GUIForm -Length 600 -Width 400

        $Form = Add-GUIFormTextBox -Form ([ref]$Servers) -x 20 -Y 50 -Length 150 -Height 20 -Title "Testing" -verbose

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

    .Notes
        Author : Jeff Buenting
        Date : 2016 DEC 02
#>

    [CmdletBinding()]
    Param (
        [Parameter ( Mandatory = $True )]
        [Ref]$Form,

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
            $Font = New-Object System.Drawing.Font( $Form.value.Font.Name,$Form.value.Font.size )
            $Size = [System.WIndows.Forms.TextRenderer]::MeasureText($Title,$Font)
            $InputX += $Size.Width + 5

            $TextTitle = New-Object System.Windows.Forms.Label 
            $TextTitle.Location = New-Object System.Drawing.Size($X,$Y)
            $TextTitle.Width = $Size.Width+5
            $TextTitle.Text = $Title
            $Form.Value.Controls.Add($TextTitle)
           
        }

        $InputBox = New-Object System.Windows.Forms.TextBox 
        $InputBox.Location = New-Object System.Drawing.Size($InputX,$Y) #location of the text box (px) in relation to the primary window's edges (length, height)
        $InputBox.Size = New-Object System.Drawing.Size($Length,$Height) #the size in px of the text box (length, height)
        $Form.Value.Controls.Add($InputBox) #activating the text box inside the Primary WIndow

        Write-Output $InputBox
    }
}

# --------------------------------------------------------------------------------

Function New-GUIFormButton {

<#
    .Synopsis
        Creates a new Windows Form Button

    .Description
        Creates a Button on a windows Form. 

    .Parameter Form
        Windows Form the button will be displayed on.

    .Parameter X
        Left pixel in the window

    .Parameter Y
        Upper pixel in the window

    .parameter Length
        Button length

    .Parameter Height
        Button Height

    .Parameter Label
        Text displayed on the button

    .Parameter Name
        Name of the button

    .Parameter Execute
        Commands to execute when the button is pressed.

    .Example
        $Form = New-GUIForm -Length 600 -Width 400

        $Check1Button_OnClick  = { Write-Host "Check1-Click, mach was.. " }
        New-GUIFormButton -Form $Form -X 400 -y 30 -Length 110 -Height 80 -Label 'Save' -Execute $Check1Button_OnClick

        $Form.add_Shown({$Form.Activate()})
        [void] $Form.ShowDialog()

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

        [Parameter ( Mandatory = $True )]
        [String]$Label,

        [string]$Name = $Label,

        

        [Parameter ( Mandatory = $True ) ]
        [ScriptBlock]$Execute
        
    )


    $Button = New-Object System.Windows.Forms.Button
    $Button.Location = New-Object System.Drawing.Size($x,$y)
    $Button.Size = New-Object System.Drawing.Size($Length,$Height)
    $Button.Name = $name
    $Button.Text = $Label
    $Button.Add_Click( $Execute )
    $Button.Cursor = [System.Windows.Forms.Cursors]::Hand
    $Form.Controls.Add($Button) 
}

# --------------------------------------------------------------------------------

Function New-GUIFormGroupBox {
    
    <#
        .Synopsis
            Allows grouping of objects in a windows form

        .Description 
            Creates a group box in a windows form.  Group boxes allow controls to be grouped.  

        .Parameter Form
            Windows Form

        .Parameter X
            left coordinate for the upper left corner

        .Parameter Y
            Upper Coordinate for the upper left corner

        .Parameter Width
            Width of the box

        .Parameter Height
            Height of the box

        .Parameter Title
            Title of the box

        .Example
            Create a group box inside of a form

            $WinLength = 600
            $WinHeight = 400

            $Form = New-GUIForm -Title 'StratusLive Install' -Length $WinLength -Height $WinHeight

            $ServerX = 10
            $ServerY = 10
            $Servers = New-GUIFormGroupBox -Form ([Ref]$Form) -Title "Servers" -X $ServerX -Y $ServerY -width 250 -Height 100

        .Link
            https://sysadminemporium.wordpress.com/2012/12/07/powershell-gui-for-your-scripts-episode-3/

        .Note
            Author : Jeff Buenting
            Date : 2016 Dec 07
    #>

    [CmdletBinding()]
    Param (
        [Parameter ( Mandatory = $True )]
        [Ref]$Form,

        [Int]$X,

        [Int]$Y,

        [int]$Width,

        [int]$Height,

        [String]$Title
    )

    $groupBox = New-Object System.Windows.Forms.GroupBox 
    $groupBox.Location = New-Object System.Drawing.Size($X,$Y) 
    $groupBox.size = New-Object System.Drawing.Size($Width,$Height) 
    $groupBox.text = $Title 

    $Form.value.Controls.Add($groupBox)

    Write-Output $groupBox
}

# --------------------------------------------------------------------------------
# --------------------------------------------------------------------------------
# --------------------------------------------------------------------------------
