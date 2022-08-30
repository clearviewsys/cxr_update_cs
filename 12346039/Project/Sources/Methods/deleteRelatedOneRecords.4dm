//%attributes = {}
// deleteRelatedOneRecords(->manyTable;->manyfieldPtr;->oneTable)

// this method MUST NOT BE used inside the trigger (on delete) for cheques, cashTransactions, etc...

// because of relate one selection method (4d docs says it is not recommended to use relate one selection inside a trigger)

// this method should supposedly delete a selection on the one table based on the selection on the many table


C_POINTER:C301($1; $manyTablePtr; $oneTablePtr; $2; $manyFieldPtr; $3)
$manyTablePtr:=$1
$manyFieldPtr:=$2
$oneTablePtr:=$3

READ ONLY:C145($oneTablePtr->)
//RELATE ONE SELECTION($manyTablePtr->;$oneTablePtr->)` this is NOT WORKING (I DON'T KNOW WHY???)

relateOneSelection($manyTablePtr; $manyFieldPtr; $oneTablePtr)
If (Records in selection:C76($oneTablePtr->)>0)
	myAlert(String:C10(Records in selection:C76($oneTablePtr->))+" records deleted from "+getElegantTableName($oneTablePtr))
End if 
READ WRITE:C146($oneTablePtr->)
DELETE SELECTION:C66($oneTablePtr->)
READ ONLY:C145($oneTablePtr->)

