//%attributes = {"publishedWeb":true}
C_TEXT:C284($listboxSet)
$listboxSet:="UserSet"

If (Records in set:C195($listboxSet)=0)
	// do nothing
Else 
	USE SET:C118($listboxSet)
	HIGHLIGHT RECORDS:C656($listboxSet)
End if 