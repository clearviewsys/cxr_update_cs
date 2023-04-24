//%attributes = {}
// handleDownArrowInPick(current form table)


C_POINTER:C301($1)

If (arrKey<Size of array:C274(arrKey))
	arrKey:=arrKey+1
	arrValue:=arrKey
	vSearchText:=arrKey{arrKey}
	GOTO SELECTED RECORD:C245($1->; arrKey)
End if 