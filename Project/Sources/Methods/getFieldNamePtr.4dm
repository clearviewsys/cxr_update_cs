//%attributes = {}
// getFieldNamePtr( tableNum;string:fieldname) -> pointer to field

C_LONGINT:C283($1)
C_TEXT:C284($2)
C_POINTER:C301($0)
C_LONGINT:C283($tableNum; $fieldNum)
$tableNum:=$1

For ($fieldNum; 1; Get last field number:C255($tableNum))
	If (Is field number valid:C1000($tableNum; $fieldNum))  // Jan 16, 2012 18:26:40 -- I.Barclay Berry 
		If (Field name:C257($1; $fieldNum)=$2)
			$0:=Field:C253($tableNum; $fieldNum)
		End if 
	End if 
End for 
