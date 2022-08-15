//%attributes = {}
// bDeleteListBoxRecords ({->[table]})


C_POINTER:C301($tablePtr; $1)

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=Current form table:C627
	: (Count parameters:C259=1)
		$tablePtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Case of 
	: (Form event code:C388=On Load:K2:1)
		enableButtonIf(isUserAuthorizedToDelete($tablePtr); "deleteButton")
	: (Form event code:C388=On Clicked:K2:4)
		deleteHighlightedRecords($tablePtr; getMainListBoxSetName($tablePtr))
End case 