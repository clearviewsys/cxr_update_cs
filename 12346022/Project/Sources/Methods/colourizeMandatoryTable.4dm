//%attributes = {}

C_LONGINT:C283($i)
C_POINTER:C301($1; $tablePtr)
$tablePtr:=$1

For ($i; 1; Get last field number:C255($tablePtr))
	If (Is field number valid:C1000($tablePtr; $i))  // Jan 16, 2012 18:24:22 -- I.Barclay Berry 
		colourizeMandatoryField(Table:C252($tablePtr); $i)
	End if 
End for 
