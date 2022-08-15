//%attributes = {}
C_TEXT:C284($listboxSet)
$listboxSet:=Table name:C256(Current form table:C627)+"_LBSet"

If (Records in set:C195($listboxSet)=0)
	// do nothing
Else 
	USE SET:C118($listboxSet)
	HIGHLIGHT RECORDS:C656($listboxSet)
End if 