//%attributes = {}
// TouchTable (->table;->anyfieldPtr; disableTriggers)

C_POINTER:C301($tablePtr; $fieldPtr; $1; $2)
C_BOOLEAN:C305($disableTrigger; $3)

Case of 
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$fieldPtr:=$2
		$disableTrigger:=True:C214
	: (Count parameters:C259=3)
		$tablePtr:=$1
		$fieldPtr:=$2
		$disableTrigger:=$3
	Else 
		$tablePtr:=->[Customers:3]
		$fieldPtr:=->[Customers:3]CustomerID:1
		$disableTrigger:=True:C214
		
End case 

checkInit
checkIfUserIsAdmin

If (isValidationConfirmed)
	
	myConfirm("Touch all records or selection of them?"; "All Records"; "Selection")
	If (OK=1)
		ALL RECORDS:C47($tablePtr->)
	Else 
		bQueryRecords($tablePtr)
	End if 
	
	If (Records in selection:C76($tablePtr->)>0)
		If ($disableTrigger)
			disableTriggers
		End if 
		
		READ WRITE:C146($tablePtr->)
		APPLY TO SELECTION:C70($tablePtr->; $fieldPtr->:=$fieldPtr->)  // just touch the records
		enableTriggers
		READ ONLY:C145($tablePtr->)
	Else 
		myAlert("No records were touched")
	End if 
	
End if 