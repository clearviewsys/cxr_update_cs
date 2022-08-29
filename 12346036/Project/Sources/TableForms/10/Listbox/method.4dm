C_LONGINT:C283(vCount)
handleListBoxFormMethod(Current form table:C627; ->vCount)

If (Form event code:C388=On Outside Call:K2:11)
	C_REAL:C285($offBalance)
	$offBalance:=Sum:C1([Registers:10]DebitLocal:23)-Sum:C1([Registers:10]CreditLocal:24)
	stampText("stamp_offBalance"; "Off Balance: "+String:C10($offBalance; "|Currency"); "red"; ($offBalance#0))
End if 