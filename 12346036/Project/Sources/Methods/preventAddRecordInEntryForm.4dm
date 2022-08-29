//%attributes = {}
// preventAddRecordInEntryForm (current form table)
// use this in EntryForm form method when you don't want the user to add a record
// to the form
C_POINTER:C301($tablePtr; $1)

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=->[AccountInOuts:37]
		
	: (Count parameters:C259=1)
		$tablePtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ASSERT:C1129(Not:C34(Is nil pointer:C315($tablePtr)); "Table Pointer is nil")

If (Form event code:C388=On Load:K2:1)
	If (Is new record:C668($tablePtr->))
		myAlert("Cannot add record via the entry form!")
		CANCEL:C270
	End if 
	
End if 