//%attributes = {}
// deleteRelatedManyRecords(->manyTable;->manyField)


C_POINTER:C301($1; $manyTablePtr; $2; $manyFieldPtr)
$manyTablePtr:=$1
$manyfieldPtr:=$2

READ WRITE:C146($manyTablePtr->)
RELATE MANY SELECTION:C340($manyFieldPtr->)
If (Records in selection:C76($manyTablePtr->)>0)
	myAlert(String:C10(Records in selection:C76($manyTablePtr->))+" records deleted from "+getElegantTableName($manyTablePtr))
End if 
DELETE SELECTION:C66($manyTablePtr->)
READ ONLY:C145($manyTablePtr->)

