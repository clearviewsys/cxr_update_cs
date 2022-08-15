//%attributes = {}
// doesRecordExist(->[table];->fieldPtr;->valuePtr)
// POST: adds the error only if the record doesn't exist
// use this method to check if a related record exist in another table 

C_POINTER:C301($1; $2; $3)
C_BOOLEAN:C305($0)
C_LONGINT:C283($found)

SET QUERY DESTINATION:C396(Into variable:K19:4; $found)
QUERY:C277($1->; $2->=$3->)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

If ($found>0)  // found result
	$0:=True:C214
Else 
	$0:=False:C215
End if 
