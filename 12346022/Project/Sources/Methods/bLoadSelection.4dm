//%attributes = {"publishedWeb":true}
C_TEXT:C284($setName)

$setName:="SavedSet_"+Table name:C256(Current form table:C627)
LOAD SET:C185(Current form table:C627->; $setName; $setName)
If (Records in set:C195($setName)>0)
	USE SET:C118($setName)
	HIGHLIGHT RECORDS:C656($setName)
End if 
CLEAR SET:C117($setName)
