//%attributes = {}
// handleUpArrowInPick (current form table)


C_POINTER:C301($1)

If (arrKey>0)
	arrKey:=arrKey-1
	arrValue:=arrKey
	vSearchText:=arrKey{arrKey}
	GOTO SELECTED RECORD:C245($1->; arrKey)
End if 
