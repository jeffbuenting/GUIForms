# ----- Get the module name
$ModulePath = "f:\github\guiforms"

$ModuleName = $ModulePath | Split-Path -Leaf

Get-Module -Name $ModuleName -All | Remove-Module -Force -verbose

Import-Module -Name "$ModulePath" -Force -ErrorAction Stop -verbose

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
