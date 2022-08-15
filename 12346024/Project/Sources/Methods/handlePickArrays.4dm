//%attributes = {}
If (Form event code:C388=On Clicked:K2:4)
	vSearchText:=arrKey{arrKey}
	GOTO SELECTED RECORD:C245(Current form table:C627->; arrKey)
End if 

If (Form event code:C388=On Double Clicked:K2:5)
	ACCEPT:C269
End if 

