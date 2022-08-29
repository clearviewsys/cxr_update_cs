//%attributes = {}
C_POINTER:C301($1)

If ((Form event code:C388=On Losing Focus:K2:8) & ($1->=""))
	
	GOTO OBJECT:C206($1->)
	
End if 
