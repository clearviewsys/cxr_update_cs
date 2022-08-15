//%attributes = {}
// displayRecordByKey (->searchKeyPtr ; recordID: string)
// use this method to display a record by passing a keyPtr and recordID
// this is a great method to call in the interface when you want the user to click on a Record ID 
// ... and open the associated record 
// e.g. displayRecordByKey (->[customers]customerID; "CUS1000")

C_POINTER:C301($tablePtr; $keyPtr)
C_TEXT:C284($referenceID)
C_LONGINT:C283($tableNum)
Case of 
	: (Count parameters:C259=2)
		$keyPtr:=$1
		$referenceID:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$tablePtr:=getTablePtrFromFieldPtr($keyPtr)

If ($referenceID#"")
	READ ONLY:C145($tablePtr->)
	QUERY:C277($tablePtr->; $keyPtr->=$referenceID)
	If (isUserAuthorizedToView($tablePtr))
		displayCurrentRecord($tablePtr)
	Else 
		myAlert_AccessDenied
	End if 
End if 