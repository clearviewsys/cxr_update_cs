//%attributes = {}
// handleCheckButton (->table;->checkField ;bool:isChecked; ->userField;->validationCodeField;validation)
C_POINTER:C301($1; $2; $4; $5; $tablePtr; $checkFieldPtr; $userFieldPtr; $validationFieldPtr)
C_BOOLEAN:C305($3; $isChecked)
C_TEXT:C284($validationCode; $6)

$tablePtr:=$1


Case of 
	: (Count parameters:C259=2)
		$checkFieldPtr:=$2
		toggleSwitchOfHighlightedSet($tablePtr; $checkFieldPtr)
		
	: (Count parameters:C259=3)
		$checkFieldPtr:=$2
		$isChecked:=$3  // true or false
		toggleSwitchOfHighlightedSet($tablePtr; $checkFieldPtr; $isChecked)
		
	: (Count parameters:C259=4)
		$checkFieldPtr:=$2
		$isChecked:=$3  // true or false
		$userFieldPtr:=$4
		toggleSwitchOfHighlightedSet($tablePtr; $checkFieldPtr; $isChecked; $userFieldPtr)
		
	: (Count parameters:C259=6)
		$checkFieldPtr:=$2
		$isChecked:=$3  // true or false
		$userFieldPtr:=$4
		$validationFieldPtr:=$5
		$validationCode:=$6
		toggleSwitchOfHighlightedSet($tablePtr; $checkFieldPtr; $isChecked; $userFieldPtr; $validationFieldPtr; $validationCode)
		
End case 
