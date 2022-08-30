//%attributes = {}
//handleViewReferenceButton (talbeNum;reference; accessGranted)
C_LONGINT:C283($1; $tableNum)
C_TEXT:C284($2; $referenceID)
C_BOOLEAN:C305($accessGranted; $3)

Case of 
	: (Count parameters:C259=2)
		$tableNum:=$1
		$referenceID:=$2
		$accessGranted:=True:C214  // by default for backward compatibility
		
	: (Count parameters:C259=3)
		$tableNum:=$1
		$referenceID:=$2
		$accessGranted:=$3  // by default for backward compatibility
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($referenceID#"")
	queryByID(Table:C252($tableNum); $referenceID)
	If ($accessGranted)
		displayCurrentRecord(Table:C252($tableNum))
	Else 
		myAlert_AccessDenied
	End if 
End if 