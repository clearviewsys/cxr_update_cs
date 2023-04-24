//%attributes = {}

C_LONGINT:C283($i)

For ($i; 1; Records in selection:C76([Registers:10]))
	
	recreateChequeFromRegister
	
	NEXT RECORD:C51([Registers:10])
End for 