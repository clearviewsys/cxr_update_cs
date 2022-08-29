//%attributes = {}
// comboBoxHandler (-> combobox ; -> [Field]Source; ->[field]destination)
//THE Destination Field is the field that you want to mutate to the value of the selected Popup
// this method handles generic combo box 
// put this method in the combo box object method 
// make sure the ON LOAD event is clicked for the combo box

C_POINTER:C301($1; $2; $3)

Case of 
	: (Form event code:C388=On Load:K2:1)
		SELECTION TO ARRAY:C260($2->; $1->)
		// once the form is loaded, assign the default value of the box to the field
		$1->{0}:=$3->
	: ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4))
		// after the combo box has been selected, assign the field to the new value    
		$3->:=$1->{0}
	: (Form event code:C388=On Losing Focus:K2:8)
		$3->:=$1->{0}
End case 