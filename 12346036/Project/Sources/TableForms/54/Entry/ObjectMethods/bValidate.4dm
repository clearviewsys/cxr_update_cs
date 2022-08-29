C_POINTER:C301($tablePtr)
$tablePtr:=Current form table:C627
If (validateTable($tablePtr))
	SAVE RECORD:C53($TablePtr->)
Else 
	REJECT:C38
End if 