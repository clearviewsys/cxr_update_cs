//%attributes = {}
C_OBJECT:C1216($1)
C_COLLECTION:C1488($2)

// this method is called from withing a col.filter to test if all elements of a collection are inside another one

If ($2.indexOf($1.value)>-1)
	$1.result:=True:C214
Else 
	$1.result:=False:C215
End if 