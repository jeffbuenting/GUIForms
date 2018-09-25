# ----- Get the module name
$ModulePath = "f:\github\guiforms"

$ModuleName = $ModulePath | Split-Path -Leaf

# ----- Remove and then import the module.  This is so any new changes are imported.
Get-Module -Name $ModuleName -All | Remove-Module -Force 

Import-Module "$ModulePath\$ModuleName.PSD1" -Force -ErrorAction Stop 

#-------------------------------------------------------------------------------------
# ----- Check if all fucntions in the module have a unit tests

Describe "$ModuleName : Module Tests" {

    $Module = Get-module -Name $ModuleName

    $testFile = Get-ChildItem $module.ModuleBase -Filter '*.Tests.ps1' -File
    
    $testNames = Select-String -Path $testFile.FullName -Pattern '[D|d]escribe\s[^\$](.+)?\s+{' | ForEach-Object {
        [System.Management.Automation.PSParser]::Tokenize($_.Matches.Groups[1].Value, [ref]$null).Content
    }

    $moduleCommandNames = (Get-Command -Module $ModuleName | where commandtype -ne alias  )

    it 'should have a test for each function' {
        Compare-Object $moduleCommandNames $testNames | where { $_.SideIndicator -eq '<=' } | select inputobject | should beNullOrEmpty
    }
}

#-------------------------------------------------------------------------------------

Describe "$ModuleName : New-GUIForm" {

    # ----- Get Function Help
    # ----- Pester to test Comment based help
    # ----- http://www.lazywinadmin.com/2016/05/using-pester-to-test-your-comment-based.html
    Context "Help" {

        $H = Help New-GuiForm -Full

        # ----- Help Tests
        It "has Synopsis Help Section" {
            $H.Synopsis | Should Not BeNullorEmpty
        }

        It "has Description Help Section" {
            $H.Description | Should Not BeNullorEmpty
        }

        It "has Parameters Help Section" {
            $H.Parameters | Should Not BeNullorEmpty
        }

        # Examples
        it "Example - Count should be greater than 0"{
            $H.examples.example.code.count | Should BeGreaterthan 0
        }
            
        # Examples - Remarks (small description that comes with the example)
        foreach ($Example in $H.examples.example)
        {
            it "Example - Remarks on $($Example.Title)"{
                $Example.remarks | Should not BeNullOrEmpty
            }
        }

        It "has Notes Help Section" {
            $H.alertSet | Should Not BeNullorEmpty
        }
    } 

    Context 'Output' {
        It "Returns a Form object" {
            $F = New-GuiForm -Title 'Test' -Length 100 -Height 20

            $F | Should BeofType System.Windows.Forms.Form
        }
    }
}

#-------------------------------------------------------------------------------------
write-Output "`n`n"

Describe "$ModuleName : New-GUIFormInputBox" {

    # ----- Get Function Help
    # ----- Pester to test Comment based help
    # ----- http://www.lazywinadmin.com/2016/05/using-pester-to-test-your-comment-based.html
    Context "Help" {

        $H = Help New-GuiFormInputBox -Full

        # ----- Help Tests
        It "has Synopsis Help Section" {
            $H.Synopsis | Should Not BeNullorEmpty
        }

        It "has Description Help Section" {
            $H.Description | Should Not BeNullorEmpty
        }

        It "has Parameters Help Section" {
            $H.Parameters | Should Not BeNullorEmpty
        }

        # Examples
        it "Example - Count should be greater than 0"{
            $H.examples.example.code.count | Should BeGreaterthan 0
        }
            
        # Examples - Remarks (small description that comes with the example)
        foreach ($Example in $H.examples.example)
        {
            it "Example - Remarks on $($Example.Title)"{
                $Example.remarks | Should not BeNullOrEmpty
            }
        }

        It "has Notes Help Section" {
            $H.alertSet | Should Not BeNullorEmpty
        }
    } 

    # ----- Mocking the object ( and function ) is giving me issues as I am using a variable ref in my test functions.  So I will use the actual function for the test.
 #   Mock New-GuiForm {
 #       New-MockObject -Type System.Windows.Forms.Form
 #   }

    Context Execution {
        
        # ----- Test no title included
        $Form = New-GUIForm -Length 600 -Height 300 -Title Form
        $InputBox = New-GUIFormInputBox -Form ([ref]$Form) -X 20 -Y 20 -Length 30 -Height 10 
        
        It "Without Title should only have one control" {
            $Form.Controls.Count | Should Be 1
        }

        It "Without Title should have a control of type TextBox" {
            $Form.Controls | Should BeOfType System.Windows.Forms.TextBox
        }

        # ----- Test including Title
        $Form = New-GUIForm -Length 600 -Height 300 -Title Form
        $InputBox = New-GUIFormInputBox -Form ([ref]$Form) -X 20 -Y 20 -Length 30 -Height 10 -Title 'Form Title'
        
        It "With Title should only have Two controls" {
            $Form.Controls.Count | Should Be 2
        }

        It "With Title should have a control of type Label" {
            $Form.Controls[0] | Should BeOfType System.Windows.Forms.Label
        }

        It "With Title should have a control of type TextBox" {
            $Form.Controls[1] | Should BeOfType System.Windows.Forms.TextBox
        }


    }

    Context Output {
        $Form = New-GUIForm -Length 600 -Height 300 -Title Form
        $InputBox = New-GUIFormInputBox -Form ([ref]$Form) -X 20 -Y 20 -Length 30 -Height 10 -Title "apple sauce"

        It "Should Return System.Windows.Forms.TextBox Object" {
            $InputBox | Should BeOfType System.Windows.Forms.TextBox 
        }

    }
}

# --------------------------------------------------------------------------------
write-Output "`n`n"

Describe "$ModuleName : New-GUIFormButton" {
        # ----- Get Function Help
    # ----- Pester to test Comment based help
    # ----- http://www.lazywinadmin.com/2016/05/using-pester-to-test-your-comment-based.html
    Context "Help" {

        $H = Help New-GuiFormButton -Full

        # ----- Help Tests
        It "has Synopsis Help Section" {
            $H.Synopsis | Should Not BeNullorEmpty
        }

        It "has Description Help Section" {
            $H.Description | Should Not BeNullorEmpty
        }

        It "has Parameters Help Section" {
            $H.Parameters | Should Not BeNullorEmpty
        }

        # Examples
        it "Example - Count should be greater than 0"{
            $H.examples.example.code.count | Should BeGreaterthan 0
        }
            
        # Examples - Remarks (small description that comes with the example)
        foreach ($Example in $H.examples.example)
        {
            it "Example - Remarks on $($Example.Title)"{
                $Example.remarks | Should not BeNullOrEmpty
            }
        }

        It "has Notes Help Section" {
            $H.alertSet | Should Not BeNullorEmpty
        }
    } 

    Context Output {
        $Form = New-GUIForm -Length 600 -Height 300 -Title Form
        New-GUIFormButton -Form $Form -X ($Form.ClientRectangle.Width-120) -y ($Form.ClientRectangle.Height-60) -Length 110 -Height 50 -Label 'Save' -Execute { $Form.Close() }
        
        It "Adds only one control to the Form" {
            $Form.Controls.Count | Should Be 1
        }

        It "Adds a control of type Button" {
            $Form.Controls | Should BeOfType System.Windows.Forms.ButtonBase
        }
    }
}

# --------------------------------------------------------------------------------
write-Output "`n`n"

Describe "$ModuleName : New-GUIFormGroupBox" {
        # ----- Get Function Help
    # ----- Pester to test Comment based help
    # ----- http://www.lazywinadmin.com/2016/05/using-pester-to-test-your-comment-based.html
    Context "Help" {

        $H = Help New-GUIFormGroupBox -Full

        # ----- Help Tests
        It "has Synopsis Help Section" {
            $H.Synopsis | Should Not BeNullorEmpty
        }

        It "has Description Help Section" {
            $H.Description | Should Not BeNullorEmpty
        }

        It "has Parameters Help Section" {
            $H.Parameters | Should Not BeNullorEmpty
        }

        # Examples
        it "Example - Count should be greater than 0"{
            $H.examples.example.code.count | Should BeGreaterthan 0
        }
            
        # Examples - Remarks (small description that comes with the example)
        foreach ($Example in $H.examples.example)
        {
            it "Example - Remarks on $($Example.Title)"{
                $Example.remarks | Should not BeNullOrEmpty
            }
        }

        It "has Notes Help Section" {
            $H.alertSet | Should Not BeNullorEmpty
        }
    } 

    Context Output {
        $F = New-GuiForm -Title 'Test' -Length 100 -Height 20
        $GB = New-GUIFormGroupBox -Form ([Ref]$F) -Title "GB 1" -X ($ServerX+260) -Y $ServerY -Length 500 -Height 100

        It "Adds only one control to the Form" {
            $F.Controls.Count | Should Be 1
        }

        It "Adds a control of type Control" {
            $F.Controls | Should BeOfType System.Windows.Forms.Control
        }

        It "Returns a GroupBox object" {

            $GB | Should BeofType System.Windows.Forms.GroupBox
        }
    }
}

# --------------------------------------------------------------------------------
write-Output "`n`n"

Describe "$ModuleName : Show-GUIForm" {
        # ----- Get Function Help
    # ----- Pester to test Comment based help
    # ----- http://www.lazywinadmin.com/2016/05/using-pester-to-test-your-comment-based.html
    Context "Help" {

        $H = Help Show-GUIForm -Full

        # ----- Help Tests
        It "has Synopsis Help Section" {
            $H.Synopsis | Should Not BeNullorEmpty
        }

        It "has Description Help Section" {
            $H.Description | Should Not BeNullorEmpty
        }

        It "has Parameters Help Section" {
            $H.Parameters | Should Not BeNullorEmpty
        }

        # Examples
        it "Example - Count should be greater than 0"{
            $H.examples.example.code.count | Should BeGreaterthan 0
        }
            
        # Examples - Remarks (small description that comes with the example)
        foreach ($Example in $H.examples.example)
        {
            it "Example - Remarks on $($Example.Title)"{
                $Example.remarks | Should not BeNullOrEmpty
            }
        }

        It "has Notes Help Section" {
            $H.alertSet | Should Not BeNullorEmpty
        }
    } 

    Context Output {
        # ----- Don't know how to check if the form is displayed on the screen or not.  I am sure there is a status somewhere
    }
}