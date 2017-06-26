# ----- Get the module name
$ModulePath = "f:\github\guiforms"

$ModuleName = $ModulePath | Split-Path -Leaf

# ----- Remove and then import the module.  This is so any new changes are imported.
Get-Module -Name $ModuleName -All | Remove-Module -Force -verbose

Import-Module "$ModulePath\$ModuleName.PSD1" -Force -ErrorAction Stop -verbose

#-------------------------------------------------------------------------------------

Describe "New-GUIForm" {

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

Describe "New-GUIFormInputBox" {

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

Describe New-GUIFormButton {
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
        # ----- Need to figure out how to check that $Form has been updated.
    }
}