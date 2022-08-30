//%attributes = {}
// handlePickListObjectMethod ({->listBox})

C_POINTER:C301($1; $listBoxPtr)
If (Count parameters:C259=1)
	$listBoxPtr:=$1
Else 
	$listBoxPtr:=Focus object:C278
End if 

//If (Form event=On Load )
//$listBoxPtr->{1}:=True  ` select first item
//End if   ` 

If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Selection Change:K2:29))
	vSearchText:=arrKey{getListBoxRowNumber($listBoxPtr)}
	GOTO SELECTED RECORD:C245(Current form table:C627->; arrKey)
End if 


If (Form event code:C388=On Double Clicked:K2:5)
	ACCEPT:C269
End if 


