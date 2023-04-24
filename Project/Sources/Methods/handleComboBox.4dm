//%attributes = {}
// handleComboBox (-> combobox ; -> [Field];listName)

// this method handles generic combo box 
// put this method in the combo box object method 
// make sure the ON LOAD event is clicked for the combo box

C_POINTER:C301($1; $comboPtr; $2; $fieldPtr)
C_TEXT:C284($3; $listName)

$comboPtr:=$1
$fieldPtr:=$2
$listName:=$3

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222($comboPtr->; 0)
		LIST TO ARRAY:C288($listName; $1->)
		// once the form is loaded, assign the default value of the box to the field
		$1->{0}:=$fieldPtr->
		
	: (Form event code:C388#On Load:K2:1)
		// after the combo box has been selected, assign the field to the new value    
		$fieldPtr->:=$comboPtr->{0}
		
End case 