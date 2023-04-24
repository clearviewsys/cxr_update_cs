//%attributes = {}
// checkifRecordExists(->[table];->[field (from same table as account)];->valueField;fieldName;{"warning"})
// POST: adds the error only if the record doesn't exist
// use this method to check if a related record exist in another table 

C_POINTER:C301($1; $2; $3)
C_TEXT:C284($4; $5)
C_LONGINT:C283($found)

SET QUERY DESTINATION:C396(Into variable:K19:4; $found)
QUERY:C277($1->; $2->=$3->)

If ($found=0)
	checkAddErrorOnTrue((Count parameters:C259=4); $4+" is not valid. ")
End if 
SET QUERY DESTINATION:C396(Into current selection:K19:1)
