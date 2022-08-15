//%attributes = {}
// checkifRelatedManyRecordExist (->[manyTable];->manyField;"field name";{warning})


C_LONGINT:C283($records)
C_TEXT:C284($recordName)

READ ONLY:C145($1->)

If (Count parameters:C259>=3)
	$recordName:=$3
Else 
	$recordName:=getElegantTableName($1)
End if 

$records:=countRelatedManySelection($1; $2)
If ($records>0)
	checkAddErrorOnTrue((Count parameters:C259<4); ("There are "+String:C10($records)+" "+$recordName+" records linked to the current selection."))
End if 
