//%attributes = {}
// handleCB_relateOne (->checkboxObject; ->manyField_CustomerID;listBoxObject)
// this method activates a relation when the checkbox is clicked
// use case: use it to display the customer names in the registers table (when clicked)
// e.g. methodname (self; ->[registers]customerID)

C_POINTER:C301($self; $1; $fieldPtr; $2)
C_TEXT:C284($listBox; $3)
$listBox:="mainListBox"
Case of 
	: (Count parameters:C259=0)
		$self:=Self:C308
		$fieldPtr:=->[Registers:10]CustomerID:5
		
	: (Count parameters:C259=1)
		$self:=$1
		$fieldPtr:=->[Registers:10]CustomerID:5
		
	: (Count parameters:C259=2)
		$self:=$1
		$fieldPtr:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($self->=1)
	SET FIELD RELATION:C919($fieldPtr->; Automatic:K51:4; Manual:K51:3)
Else 
	SET FIELD RELATION:C919($fieldPtr->; Manual:K51:3; Manual:K51:3)
End if 

// refresh the 'mainlistbox' listbox without using the variable name mainListBox
C_POINTER:C301($listBoxPtr)
$listBoxPtr:=OBJECT Get pointer:C1124(Object named:K67:5; $listBox)
If (Is nil pointer:C315($listBoxPtr))
	// do nothing if the object name is not valid
Else 
	REDRAW:C174($listBoxPtr->)
End if 