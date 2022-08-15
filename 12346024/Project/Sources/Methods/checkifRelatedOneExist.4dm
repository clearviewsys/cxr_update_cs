//%attributes = {}
// checkifRelatedOneRecordExist (->[manyTable];->manyFieldPtr;->[oneTable];->oneFieldPtr;"field name";{warning})

C_POINTER:C301($1; $2; $3; $4)
C_POINTER:C301($1; $manyTablePtr; $oneTablePtr; $oneFieldPtr; $manyFieldPtr; $4; $2; $3)
C_LONGINT:C283($records)
$manyTablePtr:=$1
$manyFieldPtr:=$2
$oneTablePtr:=$3
$oneFieldPtr:=$4

C_TEXT:C284($5; $fieldName)
$fieldName:=$5

$records:=countRelatedOneSelection($manyTablePtr; $manyFieldPtr; $oneTablePtr; $oneFieldPtr)
If ($records>0)
	checkAddErrorOnTrue((Count parameters:C259=5); ("There are "+String:C10($records)+" "+$fieldName+" records in "+getElegantTableName($oneTablePtr)+" linked to the current selection."))
End if 
