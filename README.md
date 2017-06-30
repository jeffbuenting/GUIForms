# GUIForms

Powershell cmdlets to build GUI Forms in WIndows

### Resources

- **New-GUIForm**
  -  Creates a new Gui Form Window.  Once the windows object is created, different textboxes and buttons can be added.  Primarily used for input.
  
  - **`[Int]`Length** (_Mandatory_): Length of the window.
  - **`[Int]`Height** (_Mandatory_): Height of the WIndow.
  
- **New-GUIFormInputBox**
  -  Add a text InputBox to a WIndows Gui Form.
  
  - **`[Ref]`Form** (_Mandatory_): WIndows Form.
  - **`[String]`Title**: Title for the textbox.
  - **`[Int]`X** (_Mandatory_): Left coordinate in the Parent window Form
  - **`[Int]`Y** (_Mandatory_): Upper Coordinate in the Parent window Form
  - **`[Int]`Length** (_Mandatory_): Length of the input box
  - **`[Int]`Height** (_Mandatory_): Height of the Input Box
  
- **New-GuiFormButton**
	-  Creates a Button on a windows Form.
	
  - **`[Ref]`Form** (_Mandatory_): WIndows Form .
  - **`[String]`Label**: Text displayed on the button.
  - **`[Int]`X** (_Mandatory_): Left coordinate in the Parent window Form
  - **`[Int]`Y** (_Mandatory_): Upper Coordinate in the Parent window Form
  - **`[Int]`Length** (_Mandatory_): Length of the input box
  - **`[Int]`Height** (_Mandatory_): Height of the Input Box
  - **`[String]`Name**: Name of the label.
  - **`[String]`Execute (_Mandatory_): command to execute when the button is clicked.
  
-  **New-GUIFormGroupBox**
  - Creates a group box in a windows form.  Group boxes allow controls to be grouped.
  
  - **`[Ref]`Form** (_Mandatory_): WIndows Form to add the TextBox.
  - **`[String]`Title**: Title for the textbox.
  - **`[Int]`X** (_Mandatory_): Left coordinate in the Parent window Form
  - **`[Int]`Y** (_Mandatory_): Upper Coordinate in the Parent window Form
  - **`[Int]`Length** (_Mandatory_): Length of the input box
  - **`[Int]`Height** (_Mandatory_): Height of the Input Box
  
- ** Show-GUIForm**

  - Shows and Activates a Windows Form.
  
  - **`[System.windows.forms.form]`Form** (_Mandatory_): WIndows Form.
  