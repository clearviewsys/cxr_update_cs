//%attributes = {}
// selectOrphanedRecords(->manytable;->manyField;->oneTable)


C_POINTER:C301($manyTablePtr; $oneTablePtr; $manyfieldPtr)
$manyTablePtr:=$1
$manyFieldPtr:=$2
$oneTablePtr:=$3


CREATE EMPTY SET:C140($manyTablePtr->; "$orphanIDs")
READ ONLY:C145($manyTablePtr->)
ALL RECORDS:C47($manyTablePtr->)
checkInit
If (Records in selection:C76($manyTablePtr->)>100)
	checkAddWarning("This may take a while, would you like to continue.")
End if 

If (isValidationConfirmed)
	While (Not:C34(End selection:C36($manyTablePtr->)))
		RELATE ONE:C42($manyFieldPtr->)
		If (Records in selection:C76($oneTablePtr->)=0)
			ADD TO SET:C119($manyTablePtr->; "$orphanIDs")
		End if 
		NEXT RECORD:C51($manyTablePtr->)
	End while 
	
	USE SET:C118("$orphanIDs")
	HIGHLIGHT RECORDS:C656($manyTablePtr->; "$orphanIDs")
	CLEAR SET:C117("$orphanIDs")
End if 