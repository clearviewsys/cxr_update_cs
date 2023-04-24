//%attributes = {}
// handleSalutationCombo (->comboBoxPtr; ->salutationFieldPtr; ->genderFieldPtr)
// handleSalutationCombo (SalutationFieldPtr; genderFieldPtr)

C_POINTER:C301($self; $1; $salutationfieldPtr; $2; $genderFieldPtr; $3)

$self:=$1
$salutationfieldPtr:=$2
$genderFieldPtr:=$3

handleComboBox($self; $salutationfieldPtr; "Titles")

C_TEXT:C284($selection)
$selection:=$self->{$self->}
If ($genderFieldPtr->="")  // only changed if the Gender field doesn't have a value
	Case of 
		: ($selection="Mr.")  // mr. 
			$genderFieldPtr->:="M"
		: (($selection="Ms.") | ($selection="Mrs.") | ($selection="Miss."))  // mrs. miss, ms. 
			$genderFieldPtr->:="F"
		Else 
			$genderFieldPtr->:=""
	End case 
End if 
//postTabKey
//GOTO OBJECT([Customers]FirstName)

